BACKUP - Phiên bản game đang chơi (trước khi áp patch tối ưu RAM)
==================================================================
Ngày tạo: 23/10/2026
Nguồn:     D:\Kingdom Rush Frontiers Tower Defense v5.4.07\KingdomRushFL-main 8.0.3\

Files đã backup:
  all\director.lua      53,885 bytes
  all\exoskeleton.lua   14,822 bytes
  all\game.lua          60,482 bytes
  all\systems.lua      135,752 bytes

Ghi chú:
  - dove_modules\perf\memory_guard.lua KHÔNG tồn tại trong game hiện tại
    (đây là file MỚI của bản patch, nên không cần backup)
  - Đây là phiên bản bạn đang chơi TRƯỚC KHI áp FL803_MemoryOpt patch

Cách rollback:
  Chép đè 4 file trong all\ của backup này vào:
    D:\Kingdom Rush Frontiers Tower Defense v5.4.07\KingdomRushFL-main 8.0.3\all\
  Xoá file dove_modules\perf\memory_guard.lua (nếu đã cài patch)
