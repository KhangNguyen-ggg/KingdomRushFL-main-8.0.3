return {
	fps = 30,
	partScaleCompensation = 1,
	animations = {
		{
			name = "run",
			frames = {
				{ parts = {
					{ name = "asst_torre_volcan_proyectil_fuego", xform = {x=0.7,y=0.2,kx=0.0,ky=0.0,r=0.0,sx=1.0,sy=1.0} },
					{ name = "asst_torre_volcan_proyectl_bola", xform = {x=0.15,y=0.2,kx=0.0,ky=0.0,r=0.0,sx=1.0,sy=1.0} },
				},
				},
			},
		},
	},
	parts = {
		["asst_torre_volcan_proyectil_fuego"] = { name = "asst_torre_volcan_proyectil_fuego", offsetX = 0, offsetY = 0 },
		["asst_torre_volcan_proyectl_bola"] = { name = "asst_torre_volcan_proyectl_bola", offsetX = 0, offsetY = 0 },
	},
}
