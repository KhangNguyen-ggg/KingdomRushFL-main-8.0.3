local M = {}

M.RED = {
	210,
	38,
	32,
	255
}

M.BLUE = {
	45,
	118,
	225,
	255
}

local function utf8_char_length(byte)
	if not byte or byte < 128 then
		return 1
	elseif byte < 224 then
		return 2
	elseif byte < 240 then
		return 3
	end

	return 4
end

local function utf8_code(text, index, length)
	local b1 = string.byte(text, index)

	if length == 1 then
		return b1
	elseif length == 2 then
		local b2 = string.byte(text, index + 1)

		return (b1 % 32) * 64 + (b2 % 64)
	elseif length == 3 then
		local b2, b3 = string.byte(text, index + 1, index + 2)

		return (b1 % 16) * 4096 + (b2 % 64) * 64 + (b3 % 64)
	end

	local b2, b3, b4 = string.byte(text, index + 1, index + 3)

	return (b1 % 8) * 262144 + (b2 % 64) * 4096 + (b3 % 64) * 64 + (b4 % 64)
end

local function is_cjk(code)
	return code and code >= 19968 and code <= 40959
end

local function tokenize(text)
	local tokens = {}
	local i = 1

	text = tostring(text or "")

	while i <= #text do
		local byte = string.byte(text, i)
		local start = i

		if byte >= 48 and byte <= 57 then
			i = i + 1

			while i <= #text do
				local b = string.byte(text, i)

				if not ((b >= 48 and b <= 57) or b == 37 or b == 46) then
					break
				end

				i = i + 1
			end
		elseif (byte >= 65 and byte <= 90) or (byte >= 97 and byte <= 122) or byte == 95 then
			i = i + 1

			while i <= #text do
				local b = string.byte(text, i)

				if not ((b >= 65 and b <= 90) or (b >= 97 and b <= 122) or b == 95) then
					break
				end

				i = i + 1
			end
		elseif byte == 9 or byte == 10 or byte == 13 or byte == 32 then
			i = i + 1

			while i <= #text do
				local b = string.byte(text, i)

				if b ~= 9 and b ~= 10 and b ~= 13 and b ~= 32 then
					break
				end

				i = i + 1
			end
		else
			local length = utf8_char_length(byte)
			local code = utf8_code(text, i, length)

			i = i + length

			if is_cjk(code) then
				while i <= #text do
					local next_length = utf8_char_length(string.byte(text, i))
					local next_code = utf8_code(text, i, next_length)

					if not is_cjk(next_code) then
						break
					end

					i = i + next_length
				end
			end
		end

		table.insert(tokens, string.sub(text, start, i - 1))
	end

	return tokens
end

local function matched_tokens(current, counterpart)
	local rows = {
		[0] = {}
	}

	for i = 1, #current do
		rows[i] = {
			[0] = 0
		}

		for j = 1, #counterpart do
			if current[i] == counterpart[j] then
				rows[i][j] = (rows[i - 1][j - 1] or 0) + 1
			else
				rows[i][j] = math.max(rows[i - 1][j] or 0, rows[i][j - 1] or 0)
			end
		end
	end

	local matched = {}
	local pairs = {}
	local i, j = #current, #counterpart

	while i > 0 and j > 0 do
		if current[i] == counterpart[j] then
			matched[i] = true
			table.insert(pairs, 1, {
				i,
				j
			})
			i = i - 1
			j = j - 1
		elseif (rows[i - 1][j] or 0) >= (rows[i][j - 1] or 0) then
			i = i - 1
		else
			j = j - 1
		end
	end

	return matched, pairs
end

function M.diff_runs(text, counterpart)
	if type(text) ~= "string" or type(counterpart) ~= "string" or text == counterpart then
		return nil
	end

	local current = tokenize(text)
	local other = tokenize(counterpart)
	local matched = matched_tokens(current, other)
	local runs = {}
	local changed = false

	for i, token in ipairs(current) do
		local red = not matched[i]
		local previous = runs[#runs]

		changed = changed or red

		if previous and previous.red == red then
			previous.text = previous.text .. token
		else
			table.insert(runs, {
				text = token,
				color = red and M.RED or nil,
				red = red
			})
		end
	end

	return changed and runs or nil
end

-- 一级技能没有“升级前”文本，因此只标出它在下一级会变化的部分。
-- 这里不显示箭头或下一级数值，避免把一级说明误写成升级结果。
function M.next_upgrade_runs(text, next_text)
	if type(text) ~= "string" or type(next_text) ~= "string" or text == "" or text == next_text then
		return nil
	end

	local current = tokenize(text)
	local next_tokens = tokenize(next_text)
	local matched = matched_tokens(current, next_tokens)
	local runs = {}
	local changed = false

	for i, token in ipairs(current) do
		local blue = not matched[i]
		local previous = runs[#runs]

		changed = changed or blue

		if previous and previous.blue == blue then
			previous.text = previous.text .. token
		else
			table.insert(runs, {
				text = token,
				color = blue and M.BLUE or nil,
				blue = blue
			})
		end
	end

	return changed and runs or nil
end

function M.red_runs(text)
	if type(text) ~= "string" or text == "" then
		return nil
	end

	return {
		{
			text = text,
			color = M.RED,
			red = true
		}
	}
end

local function append_run(runs, text, color, style)
	if not text or text == "" then
		return
	end

	local previous = runs[#runs]

	if previous and previous.style == style then
		previous.text = previous.text .. text
	else
		table.insert(runs, {
			text = text,
			color = color,
			style = style
		})
	end
end

local function join_tokens(tokens, first, last)
	local parts = {}

	for i = first, last do
		table.insert(parts, tokens[i])
	end

	return table.concat(parts)
end

local function has_visible_text(text)
	return text and string.gsub(text, "%s+", "") ~= ""
end

function M.upgrade_runs(before, after)
	if type(after) ~= "string" or after == "" then
		return nil
	end

	before = type(before) == "string" and before or ""

	-- 一级技能没有“升级前”的同级说明，保持原本颜色即可。
	if not has_visible_text(before) then
		return nil
	end

	if before == after then
		return nil
	end

	local old_tokens = tokenize(before)
	local new_tokens = tokenize(after)
	local _, pairs = matched_tokens(old_tokens, new_tokens)
	local runs = {}
	local old_index, new_index = 1, 1

	local function add_gap(old_last, new_last)
		local old_text = join_tokens(old_tokens, old_index, old_last)
		local new_text = join_tokens(new_tokens, new_index, new_last)
		local has_old = has_visible_text(old_text)
		local has_new = has_visible_text(new_text)

		if has_old and has_new then
			append_run(runs, old_text, M.RED, "old")
			append_run(runs, "→", nil, "plain")
			append_run(runs, new_text, M.BLUE, "new")
		elseif has_old then
			append_run(runs, old_text, M.RED, "old")
			append_run(runs, "→", nil, "plain")
			append_run(runs, "Đã loại bỏ", M.BLUE, "new")
		elseif has_new then
			append_run(runs, new_text, M.BLUE, "new")
		elseif new_text ~= "" then
			append_run(runs, new_text, nil, "plain")
		end
	end

	for _, pair in ipairs(pairs) do
		add_gap(pair[1] - 1, pair[2] - 1)
		append_run(runs, new_tokens[pair[2]], nil, "plain")
		old_index = pair[1] + 1
		new_index = pair[2] + 1
	end

	add_gap(#old_tokens, #new_tokens)

	return #runs > 0 and runs or nil
end

function M.runs_text(runs, fallback)
	if type(runs) ~= "table" or #runs == 0 then
		return fallback or ""
	end

	local parts = {}

	for _, run in ipairs(runs) do
		table.insert(parts, run.text or "")
	end

	return table.concat(parts)
end

return M
