# Bugs

## Backwards compatibility.
## Question : Why does the percent fill OK on mini_prob
## [DONE!] Can go <0 && >100

$(document).ready ->

	make_rect = (rect, d) ->
        rect.attr("x", d.x)
            .attr("y", d.y)
            .attr("width", d.width)
            .attr("height", d.height)
            .attr("fill", d.fill)
            .attr("opacity", d.opacity)
            .attr("id", d.id)

	# Global variables
	p_sprinkler_rain_value = 0
	p_sprinkler_not_rain_value = 0

	p_rain_value = 0
	p_rain_value_PX = 0

	rect_p_sprinkler_not_rain_base_width = 0


	# ██████╗ ██████╗ ██╗ ██████╗ ██████╗     ███████╗██╗██╗      ██████╗ 
	# ██╔══██╗██╔══██╗██║██╔═══██╗██╔══██╗    ██╔════╝██║██║     ██╔═══██╗
	# ██████╔╝██████╔╝██║██║   ██║██████╔╝    ███████╗██║██║     ██║   ██║
	# ██╔═══╝ ██╔══██╗██║██║   ██║██╔══██╗    ╚════██║██║██║     ██║   ██║
	# ██║     ██║  ██║██║╚██████╔╝██║  ██║    ███████║██║███████╗╚██████╔╝
	# ╚═╝     ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝    ╚══════╝╚═╝╚══════╝ ╚═════╝
	# Prior Silo for BOX-PROB

	PRIOR_SILO_square_size = 300
	PRIOR_SILO_xCoord = 0
	PRIOR_SILO_yCoord = 0

	PRIOR_SILO_p_rain_value = 0
	PRIOR_SILO_p_rain_value_PX = 0

	svgContainer_box_PRIOR_SILO = d3.select("#area_for_boxprob_PRIOR_SILO")
									.append("svg")
									.attr("width", "300").attr("height", "100%")

	console.log("/////")
	console.log(svgContainer_box_PRIOR_SILO)

	PRIOR_SILO_base_rect = svgContainer_box_PRIOR_SILO.append("rect")
	PRIOR_SILO_rect_p_rain = svgContainer_box_PRIOR_SILO.append("rect")

	PRIOR_SILO_dragger_p_rain = svgContainer_box_PRIOR_SILO.append("rect")

	PRIOR_SILO_draw_boxprob_base = ->
		make_rect(PRIOR_SILO_base_rect,
			x: PRIOR_SILO_xCoord
			y: PRIOR_SILO_yCoord
			width: PRIOR_SILO_square_size
			height: PRIOR_SILO_square_size
			fill: "#ffa9aa"
			opacity: 0.8
			id: "PRIOR_SILO_base_rect")

	# Define opacity to make the box darker as we drag
	PRIOR_SILO_rect_p_rain_opacity = 1

	PRIOR_SILO_draw_boxprob_rectangles = ->
		# Rectangles
		make_rect(PRIOR_SILO_rect_p_rain,
			x: PRIOR_SILO_xCoord
			y: PRIOR_SILO_yCoord
			width: PRIOR_SILO_p_rain_value_PX
			height: PRIOR_SILO_square_size
			fill: "#e44547"
			opacity: 0.8
			id: "PRIOR_SILO_rect_p_rain")

		# Dragger
		make_rect(PRIOR_SILO_dragger_p_rain,
			x: PRIOR_SILO_p_rain_value_PX
			y: PRIOR_SILO_yCoord
			width: 5
			height: PRIOR_SILO_square_size
			fill: "#b80b00"
			opacity: 1
			id: "PRIOR_SILO_dragger_p_rain")

	# Dragging methods
	PRIOR_SILO_drag_rain_xCoord = 0

	PRIOR_SILO_on_drag_rain = (d) ->

		PRIOR_SILO_drag_rain_xCoord = d3.event.x
		yCoord = d3.event.y
		PRIOR_SILO_p_rain_value = (PRIOR_SILO_drag_rain_xCoord/PRIOR_SILO_square_size)*100
		PRIOR_SILO_p_rain_value = Math.round(PRIOR_SILO_p_rain_value)

		# Clamp: takes the bigger of the two values
		PRIOR_SILO_p_rain_value = Math.min(PRIOR_SILO_p_rain_value, 100)
		PRIOR_SILO_p_rain_value = Math.max(0, PRIOR_SILO_p_rain_value)

		$('#PRIOR_SILO_p_rain').val(PRIOR_SILO_p_rain_value)

		PRIOR_SILO_text_label_move()
		PRIOR_SILO_pixel_updater()
		PRIOR_SILO_draw_boxprob_rectangles()
		PRIOR_SILO_calendar_update()

	PRIOR_SILO_draw_boxprob_base()

	PRIOR_SILO_drag_rain = d3.behavior.drag()
								.on("drag", PRIOR_SILO_on_drag_rain)

	PRIOR_SILO_dragger_p_rain.call(PRIOR_SILO_drag_rain)

	# User input

	$('#PRIOR_SILO_p_rain').keyup ->
		PRIOR_SILO_p_rain_value = $('#PRIOR_SILO_p_rain').val()

		PRIOR_SILO_pixel_updater()
		PRIOR_SILO_calendar_update()

		PRIOR_SILO_draw_boxprob_rectangles()

	PRIOR_SILO_pixel_updater = ->
		$('#PRIOR_SILO_p_rain_NOT').val(100-PRIOR_SILO_p_rain_value)
		PRIOR_SILO_p_rain_value_PX = (PRIOR_SILO_p_rain_value*PRIOR_SILO_square_size)/100		

	PRIOR_SILO_text_label_move = ->
		# p_rain
		$('#PRIOR_SILO_p_rain_div').css({
			left: Math.max(0, Math.min(PRIOR_SILO_drag_rain_xCoord - 55,300))
			})

	# ██╗     ██╗██╗  ██╗███████╗██╗     ██╗██╗  ██╗ ██████╗  ██████╗ ██████╗     ███████╗██╗██╗      ██████╗ 
	# ██║     ██║██║ ██╔╝██╔════╝██║     ██║██║  ██║██╔═══██╗██╔═══██╗██╔══██╗    ██╔════╝██║██║     ██╔═══██╗
	# ██║     ██║█████╔╝ █████╗  ██║     ██║███████║██║   ██║██║   ██║██║  ██║    ███████╗██║██║     ██║   ██║
	# ██║     ██║██╔═██╗ ██╔══╝  ██║     ██║██╔══██║██║   ██║██║   ██║██║  ██║    ╚════██║██║██║     ██║   ██║
	# ███████╗██║██║  ██╗███████╗███████╗██║██║  ██║╚██████╔╝╚██████╔╝██████╔╝    ███████║██║███████╗╚██████╔╝
	# ╚══════╝╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═════╝     ╚══════╝╚═╝╚══════╝ ╚═════╝

	LIKELIHOOD_SILO_square_size = 300
	LIKELIHOOD_SILO_xCoord = 0
	LIKELIHOOD_SILO_yCoord = 0

	LIKELIHOOD_SILO_p_rain_value = 80
	LIKELIHOOD_SILO_p_rain_value_PX = (LIKELIHOOD_SILO_p_rain_value/100)*LIKELIHOOD_SILO_square_size

	LIKELIHOOD_SILO_p_sprinkler_rain_value = 0
	LIKELIHOOD_SILO_p_sprinkler_rain_value_PX = 0

	svgContainer_box_LIKELIHOOD_SILO = d3.select("#area_for_boxprob_LIKELIHOOD_SILO")
										.append("svg")
										.attr("width", "300").attr("height", "100%")

	LIKELIHOOD_SILO_base_rect = svgContainer_box_LIKELIHOOD_SILO.append("rect")
	LIKELIHOOD_SILO_rect_p_rain = svgContainer_box_LIKELIHOOD_SILO.append("rect")
	LIKELIHOOD_SILO_rect_sprinkler_rain = svgContainer_box_LIKELIHOOD_SILO.append("rect")

	LIKELIHOOD_SILO_dragger_p_sprinkler_rain = svgContainer_box_LIKELIHOOD_SILO.append("rect")

	LIKELIHOOD_SILO_draw_boxprob_base = ->
		make_rect(LIKELIHOOD_SILO_base_rect,
			x: LIKELIHOOD_SILO_xCoord
			y: LIKELIHOOD_SILO_yCoord
			width: LIKELIHOOD_SILO_square_size
			height: LIKELIHOOD_SILO_square_size
			fill: "#ffa9aa"
			opacity: 0.8
			id: "LIKELIHOOD_SILO_base_rect")

	LIKELIHOOD_SILO_draw_boxprob_rectangles = ->
		#Rectangles
		make_rect(LIKELIHOOD_SILO_rect_p_rain,
			x: LIKELIHOOD_SILO_xCoord
			y: LIKELIHOOD_SILO_yCoord
			width: LIKELIHOOD_SILO_p_rain_value_PX
			height: LIKELIHOOD_SILO_square_size
			fill: "#e44547"
			opacity: 0.8
			id: "LIKELIHOOD_SILO_rect_p_rain")

		make_rect(LIKELIHOOD_SILO_rect_sprinkler_rain,
	    	x: LIKELIHOOD_SILO_yCoord
	    	y: LIKELIHOOD_SILO_yCoord
	    	width: LIKELIHOOD_SILO_p_sprinkler_rain_value_PX
	    	height: (LIKELIHOOD_SILO_p_sprinkler_rain_value*LIKELIHOOD_SILO_square_size)/100
	    	fill: "#f0974b"
	    	opacity: 1
	    	id: "LIKELIHOOD_SILO_rect_sprinkler_rain")

		# Draggers
		make_rect(LIKELIHOOD_SILO_dragger_p_sprinkler_rain,
			x: LIKELIHOOD_SILO_xCoord
			y: (LIKELIHOOD_SILO_p_sprinkler_rain_value*LIKELIHOOD_SILO_square_size)/100
			width: LIKELIHOOD_SILO_p_sprinkler_rain_value_PX
			height: 5
			fill: "#D13B00"
			opacity: 0.8
			id: "LIKELIHOOD_SILO_dragger_p_sprinkler_rain")

	LIKELIHOOD_SILO_draw_boxprob_base()
	LIKELIHOOD_SILO_draw_boxprob_rectangles()

	LIKELIHOOD_SILO_on_drag_sprinkler_rain = (d) ->
		LIKELIHOOD_SILO_xCoord = d3.event.x
		LIKELIHOOD_SILO_yCoord = d3.event.y

		LIKELIHOOD_SILO_p_sprinkler_rain_value_PX = LIKELIHOOD_SILO_yCoord

		# update percentages
		LIKELIHOOD_SILO_p_sprinkler_rain_value = (LIKELIHOOD_SILO_p_sprinkler_rain_value_PX*100)/LIKELIHOOD_SILO_square_size
		LIKELIHOOD_SILO_p_sprinkler_rain_value = Math.round(LIKELIHOOD_SILO_p_sprinkler_rain_value)

		LIKELIHOOD_SILO_p_sprinkler_rain_value = Math.max(0, Math.min(LIKELIHOOD_SILO_p_sprinkler_rain_value, 100))

		$('#LIKELIHOOD_SILO_p_sprinkler_rain').val(LIKELIHOOD_SILO_p_sprinkler_rain_value)

		LIKELIHOOD_SILO_pixel_updater()
		LIKELIHOOD_SILO_draw_boxprob_rectangles()

	LIKELIHOOD_SILO_drag_sprinkler_rain = d3.behavior.drag()
											.on("drag", LIKELIHOOD_SILO_on_drag_sprinkler_rain)

	LIKELIHOOD_SILO_dragger_p_sprinkler_rain.call(LIKELIHOOD_SILO_drag_sprinkler_rain)

	LIKELIHOOD_SILO_pixel_updater = ->
		# really only for p_sprinkler_rain

		LIKELIHOOD_SILO_p_sprinkler_rain_value_PX = (LIKELIHOOD_SILO_p_sprinkler_rain_value*LIKELIHOOD_SILO_p_rain_value_PX)/100



	# ██████╗  ██████╗ ██╗  ██╗    ██████╗ ██████╗  ██████╗ ██████╗ 
	# ██╔══██╗██╔═══██╗╚██╗██╔╝    ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
	# ██████╔╝██║   ██║ ╚███╔╝     ██████╔╝██████╔╝██║   ██║██████╔╝
	# ██╔══██╗██║   ██║ ██╔██╗     ██╔═══╝ ██╔══██╗██║   ██║██╔══██╗
	# ██████╔╝╚██████╔╝██╔╝ ██╗    ██║     ██║  ██║╚██████╔╝██████╔╝
	# ╚═════╝  ╚═════╝ ╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ 
	                                                              
	# BOX-PROB

	BOX_square_size = 300
	xCoord = 0
	yCoord = 0

	svgContainer_box = d3.select("#area_for_boxprob")
	 					.append("svg")
	 					.attr("width", "300").attr("height", "100%")

	BOX_base_rect = svgContainer_box.append("rect")
	BOX_rect_p_rain = svgContainer_box.append("rect")
	BOX_rect_sprinkler_rain = svgContainer_box.append("rect")
	BOX_rect_sprinkler_not_rain = svgContainer_box.append("rect")

	BOX_p_sprinkler_rain_value_PX = 0
	BOX_p_sprinkler_not_rain_value_PX = 0

	BOX_dragger_p_rain = svgContainer_box.append("rect")
	BOX_dragger_sprinkler_rain = svgContainer_box.append("rect")
	BOX_dragger_sprinkler_not_rain = svgContainer_box.append("rect")

	
	draw_boxprob_base = ->
		make_rect(BOX_base_rect,
			x: xCoord
			y: yCoord
			width: BOX_square_size
			height: BOX_square_size#*200
			fill: "#ffa9aa"
			opacity: 0.8
			id: "BOX_base_rect")

	# Define opacity to make the box darker as we drag
	BOX_rect_p_rain_opacity = 1

	draw_boxprob_rectangles = ->

		# Rectangles

		make_rect(BOX_rect_p_rain,
			x: xCoord
			y: yCoord
			width: p_rain_value_PX
			height: BOX_square_size
			fill: "#e44547"
			opacity: 0.8
			id: "BOX_rect_p_rain")

		make_rect(BOX_rect_sprinkler_rain,
	    	x: yCoord
	    	y: yCoord
	    	width: p_rain_value_PX
	    	height: (p_sprinkler_rain_value*BOX_square_size)/100#BOX_p_sprinkler_rain_value_PX#_box
	    	fill: "#f0974b"
	    	opacity: 1
	    	id: "BOX_rect_sprinkler_rain")

		BOX_p_sprinkler_not_rain_value_PX_box = (p_sprinkler_not_rain_value/100)*BOX_square_size

		make_rect(BOX_rect_sprinkler_not_rain,
	    	x: p_rain_value_PX
	    	y: yCoord
	    	width: BOX_square_size-p_rain_value_PX
	    	height: BOX_p_sprinkler_not_rain_value_PX_box
	    	fill: "#f7d13e"
	    	opacity: 1
	    	id: "BOX_rect_sprinkler_not_rain")

		# Draggers

		make_rect(BOX_dragger_p_rain,
			x: p_rain_value_PX
			y: yCoord
			width: 5
			height: BOX_square_size
			fill: "#b80b00"
			opacity: 1
			id: "BOX_dragger_p_rain")

		make_rect(BOX_dragger_sprinkler_rain,
			x: xCoord
			y: (p_sprinkler_rain_value*BOX_square_size)/100
			width: p_rain_value_PX
			height: 5
			fill: "#D13B00"
			opacity: 0.8
			id: "BOX_dragger_sprinkler_rain")

		make_rect(BOX_dragger_sprinkler_not_rain,
			x: p_rain_value_PX
			y: (p_sprinkler_not_rain_value*BOX_square_size)/100
			width: BOX_square_size-p_rain_value_PX
			height: 5
			fill: "#c8a82e"
			opacity: 0.8
			id: "BOX_dragger_sprinkler_not_rain")

	draw_boxprob_base()

	# Dragging methods

	BOX_drag_rain_xCoord = 0

	BOX_on_drag_rain = (d) ->

		# Constrain dragging
		#d.x = Math.max(0, Math.min(100, d3.event.x))
		#d.y = Math.max(0, Math.min(100, d3.event.y))

		BOX_drag_rain_xCoord = d3.event.x
		y = d3.event.y

		console.log("BOX_drag_rain_xCoord", BOX_drag_rain_xCoord)

		p_rain_value = (BOX_drag_rain_xCoord/BOX_square_size)*100
		#BOX_rect_p_rain.attr("width", p_rain_value)

		p_rain_value = Math.round(p_rain_value)

		# Clamp: takes the bigger of the two values
		p_rain_value = Math.min(p_rain_value, 100)
		p_rain_value = Math.max(0, p_rain_value)

		$('#p_rain').val(p_rain_value)

		text_label_move()
		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

		calendar_update()

		# Change background color
		BOX_rect_p_rain.attr("opacity", (BOX_rect_p_rain_opacity*p_rain_value)/100)

	BOX_on_drag_sprinkler_rain = (d) ->
		x = d3.event.x
		y = d3.event.y

		BOX_p_sprinkler_rain_value_PX = y
		#BOX_rect_sprinkler_rain.attr("height", BOX_p_sprinkler_rain_value_PX)

		p_sprinkler_rain_value = (BOX_p_sprinkler_rain_value_PX*100)/BOX_square_size # update percentages
		p_sprinkler_rain_value = Math.round(p_sprinkler_rain_value)

		# Clamp
		p_sprinkler_rain_value = Math.max(0, Math.min(p_sprinkler_rain_value, 100))

		$('#p_sprinkler_rain').val(p_sprinkler_rain_value)#_PX)

		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

	BOX_on_drag_sprinkler_not_rain = (d) ->
		x = d3.event.x
		y = d3.event.y

		BOX_p_sprinkler_not_rain_value_PX = y

		p_sprinkler_not_rain_value = (BOX_p_sprinkler_not_rain_value_PX*100)/BOX_square_size
		p_sprinkler_not_rain_value = Math.round(p_sprinkler_not_rain_value)

		# Clamp
		p_sprinkler_not_rain_value = Math.max(0, Math.min(p_sprinkler_not_rain_value, 100))

		$('#p_sprinkler_not_rain').val(p_sprinkler_not_rain_value)

		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

	# Link methods with d3 dragging behavior
	BOX_drag_rain = d3.behavior.drag()
						# .origin(->
						# 		coordinates = [0, 0]
						# 		coordinates = d3.mouse(this)
						# 		x = coordinates[0]
						# 		y = coordinates[1])
						# 		t = d3.select(BOX_drag_rain)
						# 		x = t.attr("x")
						# 		y = t.attr("y"))
						.on("drag", BOX_on_drag_rain)
						'''
						.origin(-> 
							t = d3.select(this)
							x: t.attr("x")
							y: t.attr("y"))
						'''

	BOX_drag_sprinkler_rain = d3.behavior.drag()
								#.on("dragstart", on_dragstart)
								.on("drag", BOX_on_drag_sprinkler_rain)

	BOX_drag_sprinkler_not_rain = d3.behavior.drag()
										.on("drag", BOX_on_drag_sprinkler_not_rain)

	# Link IDs with d3 dragging behavior
	BOX_dragger_p_rain.call(BOX_drag_rain)
	BOX_dragger_sprinkler_rain.call(BOX_drag_sprinkler_rain)
	BOX_dragger_sprinkler_not_rain.call(BOX_drag_sprinkler_not_rain)


	# ██████╗ ███████╗ █████╗ ███╗   ███╗
	# ██╔══██╗██╔════╝██╔══██╗████╗ ████║
	# ██████╔╝█████╗  ███████║██╔████╔██║
	# ██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║
	# ██████╔╝███████╗██║  ██║██║ ╚═╝ ██║
	# ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝

	# MINI-PROB

	svgContainer_beamprob = d3.select("#area2")
						.append("svg")

	BEAM_base_rect = svgContainer_beamprob.append("rect")
	BEAM_rect_p_rain = svgContainer_beamprob.append("rect")
	
	BEAM_rect_p_sprinkler_rain_base = svgContainer_beamprob.append("rect")
	BEAM_rect_p_sprinkler_rain_actual = svgContainer_beamprob.append("rect")

	BEAM_rect_p_sprinkler_not_rain_base = svgContainer_beamprob.append("rect")
	BEAM_rect_p_sprinkler_not_rain_actual = svgContainer_beamprob.append("rect")	

	BEAM_p_sprinkler_rain_value_PX = 0
	BEAM_p_sprinkler_not_rain_value_PX = 0

	BEAM_dragger_p_rain = svgContainer_beamprob.append("rect")
	BEAM_dragger_p_sprinkler_rain = svgContainer_beamprob.append("rect")
	BEAM_dragger_p_sprinkler_not_rain = svgContainer_beamprob.append("rect")

	BEAM_rect_rain_width = 300
	BEAM_rect_height = 50


	draw_beamprob_base = ->
		make_rect(BEAM_base_rect,
			x: 0
			y: 0
			width: BEAM_rect_rain_width
			height: BEAM_rect_height
			fill: "#ffa9aa"
			opacity: 0.8
			id: "BEAM_base_rect")

	draw_beamprob_rectangles = ->
		make_rect(BEAM_rect_p_rain,
			x: 0
			y: 0
			width: p_rain_value_PX
			height: BEAM_rect_height
			fill: "#e44547"
			opacity: 1
			id: "BEAM_rect_p_rain")

		make_rect(BEAM_rect_p_sprinkler_rain_base,
			x: 0
			y: BEAM_rect_height + 5
			width: p_rain_value_PX
			height: BEAM_rect_height
			fill: "#e44547"
			opacity: 0.8
			id: "BEAM_rect_p_sprinkler_rain_base")

		#console.log("REDRAWING")
		#console.log("p_sprinkler_rain_value", p_sprinkler_rain_value)
		#console.log("p_rain_value_PX", p_rain_value_PX)
		#console.log("(p_sprinkler_rain_value*p_rain_value_PX)/100", (p_sprinkler_rain_value*p_rain_value_PX)/100)

		make_rect(BEAM_rect_p_sprinkler_rain_actual,
			x: 0
			y: BEAM_rect_height + 5
			width: (p_sprinkler_rain_value*p_rain_value_PX)/100#_PX
			height: BEAM_rect_height
			fill: "#f0974b"
			opacity: 0.8
			id: "BEAM_rect_p_sprinkler_rain_actual")

		rect_p_sprinkler_not_rain_base_width = BEAM_rect_rain_width - p_rain_value_PX

		make_rect(BEAM_rect_p_sprinkler_not_rain_base,
			x: p_rain_value_PX
			y: BEAM_rect_height + 5
			width: rect_p_sprinkler_not_rain_base_width
			height: BEAM_rect_height
			fill: "#ffa9aa"
			opacity: 0.8
			id: "BEAM_rect_p_sprinkler_not_rain_base")

		make_rect(BEAM_rect_p_sprinkler_not_rain_actual,
			x: p_rain_value_PX
			y: BEAM_rect_height + 5
			width: BEAM_p_sprinkler_not_rain_value_PX #(p_sprinkler_not_rain_value/100)*(((1-p_rain_value)/100)*BOX_square_size) #BOX_p_sprinkler_not_rain_value_PX
			height: BEAM_rect_height
			fill: "#f7d13e"
			opacity: 0.8
			id: "BEAM_rect_p_sprinkler_not_rain_actual")

		# Draggers

		make_rect(BEAM_dragger_p_rain,
			x: p_rain_value_PX
			y: 0
			width: 5
			height: BEAM_rect_height
			fill: "#b80b00"
			opacity: 0.8
			id: "BEAM_dragger_p_rain")

		make_rect(BEAM_dragger_p_sprinkler_rain,
			x: (p_sprinkler_rain_value*p_rain_value_PX)/100
			y: BEAM_rect_height + 5
			width: 5
			height: BEAM_rect_height
			fill: "#D13B00"
			opacity: 0.8
			id: "BEAM_dragger_p_sprinkler_rain")

		make_rect(BEAM_dragger_p_sprinkler_not_rain,
			x: p_rain_value_PX + BOX_p_sprinkler_not_rain_value_PX
			y: BEAM_rect_height + 5
			width: 5
			height: BEAM_rect_height
			fill: "#c8a82e"
			opacity: 0.8
			id: "BEAM_dragger_p_sprinkler_not_rain")

	draw_beamprob_base()

	# Dragging methods

	BEAM_on_drag_rain = (d) ->
		x = d3.event.x
		y = d3.event.y

		p_rain_value = (x/BOX_square_size)*100
		p_rain_value = Math.round(p_rain_value)

		# Clamp
		p_rain_value = Math.max(0, Math.min(p_rain_value, 100))
		#p_rain_value = Math.min(p_rain_value, 100)
		#p_rain_value = Math.max(0, p_rain_value)

		$('#p_rain').val(p_rain_value)

		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

		calendar_update()


	BEAM_on_drag_sprinkler_rain = (d) ->
		x = d3.event.x
		y = d3.event.y

		#BEAM_p_sprinkler_rain_value_PX = x
		#BEAM_rect_p_sprinkler_rain_actual.attr("width", BEAM_p_sprinkler_rain_value_PX)
		
		p_sprinkler_rain_value = (x/p_rain_value_PX)*100
		p_sprinkler_rain_value = Math.round(p_sprinkler_rain_value)

		# Clamp
		p_sprinkler_rain_value = Math.max(0, Math.min(0, p_sprinkler_rain_value))

		$('#p_sprinkler_rain').val(p_sprinkler_rain_value)

		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

	BEAM_on_drag_sprinkler_not_rain = (d) ->
		x = d3.event.x
		y = d3.event.y

		#console.log("sprinkler_not_rain x coord", x)
		BEAM_p_sprinkler_not_rain_value_PX = x - p_rain_value_PX

		p_sprinkler_not_rain_value = (BEAM_p_sprinkler_not_rain_value_PX/(BOX_square_size-p_rain_value_PX)) * 100
		p_sprinkler_not_rain_value = Math.round(p_sprinkler_not_rain_value)

		# Clamp
		p_sprinkler_not_rain_value = Math.max(0, Math.min(p_sprinkler_not_rain_value, 100))

		$('#p_sprinkler_not_rain').val(p_sprinkler_not_rain_value)

		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

		console.log("BEAM_p_sprinkler_not_rain_value_PX", BEAM_p_sprinkler_not_rain_value_PX)
		console.log("p_sprinkler_not_rain_value", p_sprinkler_not_rain_value)

	# origin_fn = (d) ->
	# 	t = d3.select(this)
	# 	return {x: t.attr "x", y: t.attr "y"}

	BEAM_drag_rain = d3.behavior.drag()
							.on("drag", BEAM_on_drag_rain)

	BEAM_drag_sprinkler_rain = d3.behavior.drag()
									#.on("dragstart", on_dragstart)
									.on("drag", BEAM_on_drag_sprinkler_rain)
									#.origin(Object)

	BEAM_drag_sprinkler_not_rain = d3.behavior.drag()
						.on("drag", BEAM_on_drag_sprinkler_not_rain)

	BEAM_dragger_p_rain.call(BEAM_drag_rain)
	BEAM_dragger_p_sprinkler_rain.call(BEAM_drag_sprinkler_rain)
	BEAM_dragger_p_sprinkler_not_rain.call(BEAM_drag_sprinkler_not_rain)

	pixel_updater = ->

		$('#p_rain_NOT').val(100-p_rain_value)

		p_rain_value_PX = (p_rain_value*BEAM_rect_rain_width)/100

		# because they're all dependent
		BOX_p_sprinkler_rain_value_PX = (p_sprinkler_rain_value*p_rain_value_PX)/100
		BOX_p_sprinkler_not_rain_value_PX = (p_sprinkler_not_rain_value*rect_p_sprinkler_not_rain_base_width)/100

		BEAM_p_sprinkler_rain_value_PX = (p_sprinkler_rain_value*p_rain_value_PX)/100

		####
		BOX_p_sprinkler_rain_value_PX = (p_sprinkler_rain_value*p_rain_value_PX)/100
		p_sprinkler_rain_value_PX = (p_sprinkler_rain_value*p_rain_value_PX)/100

		BEAM_p_sprinkler_rain_value_PX = (p_sprinkler_rain_value*p_rain_value_PX)/100

		####
		BOX_p_sprinkler_not_rain_value_PX = (p_sprinkler_not_rain_value*rect_p_sprinkler_not_rain_base_width)/100
		BEAM_p_sprinkler_not_rain_value_PX = (p_sprinkler_not_rain_value/100)*(((100-p_rain_value)/100)*BOX_square_size)

		# Updates location of text

	text_label_move = ->
		## p_rain
		$('#p_rain_div').css({
			left: Math.max(0, Math.min(BOX_drag_rain_xCoord - 55,300))
			})

	# User input

	$("#p_rain").keyup ->
		p_rain_value = $('#p_rain').val()
		
		pixel_updater()
		calendar_update()

		#console.log("p_rain_value_PX", p_rain_value_PX)
		#console.log("p_sprinkler_rain_value", p_sprinkler_rain_value)
		#console.log("#### BEAM_p_sprinkler_rain_value_PX", BEAM_p_sprinkler_rain_value_PX)

		draw_beamprob_rectangles()
		draw_boxprob_rectangles()
		text_label_move()

	$("#p_sprinkler_rain").keyup ->
		p_sprinkler_rain_value = $('#p_sprinkler_rain').val()

		pixel_updater()

		draw_beamprob_rectangles()
		draw_boxprob_rectangles()

	$("#p_sprinkler_not_rain").keyup ->
		p_sprinkler_not_rain_value = $('#p_sprinkler_not_rain').val()
		pixel_updater()
		
		draw_beamprob_rectangles()
		draw_boxprob_rectangles()

                            
	#  ██████╗ ██████╗ ███╗   ██╗ ██████╗██████╗ ███████╗████████╗███████╗        ██████╗ ██████╗  ██████╗ ██████╗ 
	# ██╔════╝██╔═══██╗████╗  ██║██╔════╝██╔══██╗██╔════╝╚══██╔══╝██╔════╝        ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗
	# ██║     ██║   ██║██╔██╗ ██║██║     ██████╔╝█████╗     ██║   █████╗          ██████╔╝██████╔╝██║   ██║██████╔╝
	# ██║     ██║   ██║██║╚██╗██║██║     ██╔══██╗██╔══╝     ██║   ██╔══╝          ██╔═══╝ ██╔══██╗██║   ██║██╔══██╗
	# ╚██████╗╚██████╔╝██║ ╚████║╚██████╗██║  ██║███████╗   ██║   ███████╗███████╗██║     ██║  ██║╚██████╔╝██████╔╝
	#  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝
	# - - - - - - - [ PRIOR_SILO ] BOX DAYS - - - - - - - - - -

	# Need to take care of "pixel_updater"

	
	#discrete_prob_creator(svgContainerID, divID, link_to_BayesianBoxID, numOfSquares)

	#discrete_prob_creator(PRIOR_SILO_svgContainer_boxDays, PRIOR_SILO_area_boxDays, 5, PRIOR_SILO_p_rain_value)
	

	PRIOR_SILO_svgContainer_boxDays = d3.select("#PRIOR_SILO_area_boxDays").append("svg")

	PRIOR_SILO_num_days = 5
	PRIOR_SILO_day_dict = []
	PRIOR_SILO_daybox_size = 30

	PRIOR_SILO_x_multiplier = 30 # ???

	# draw all the individual squares
		# data structure: [RECTANGLE_NAME, O IF BLANK / 1 IF SHADED]
	PRIOR_SILO_daybox_rect_generator = ->
		for i in [0..PRIOR_SILO_num_days-1]
			PRIOR_SILO_day_dict[i] = [PRIOR_SILO_svgContainer_boxDays.append("rect"), 0]

	PRIOR_SILO_daybox_rect_generator()

	# make all the rectangles and put them in day_dict
	PRIOR_SILO_draw_concreteprob_rectangles = ->
		for i in [0..PRIOR_SILO_num_days-1]
			make_rect(PRIOR_SILO_day_dict[i][0],
				x: PRIOR_SILO_x_multiplier
				y: 30
				width: PRIOR_SILO_daybox_size
				height: PRIOR_SILO_daybox_size
				fill: "#d6d6d6"
				opacity: 0.8
				id: "PRIOR_SILO_day" + i)

			PRIOR_SILO_x_multiplier = PRIOR_SILO_x_multiplier+33

	PRIOR_SILO_draw_concreteprob_rectangles()

	PRIOR_SILO_day_box_value = 0

	$("#PRIOR_SILO_day0").click ->
		if PRIOR_SILO_day_dict[0][1] == 0
			PRIOR_SILO_day_dict[0][0].attr("fill", "blue")
			PRIOR_SILO_day_dict[0][1] = 1

		else if PRIOR_SILO_day_dict[0][1] == 1
			PRIOR_SILO_day_dict[0][0].attr("fill", "#d6d6d6")
			PRIOR_SILO_day_dict[0][1] = 0

		PRIOR_SILO_day_box_pct_fn()
		PRIOR_SILO_p_rain_value = PRIOR_SILO_day_box_value
		$('#PRIOR_SILO_p_rain').val(PRIOR_SILO_p_rain_value)

		PRIOR_SILO_pixel_updater()
		PRIOR_SILO_draw_boxprob_rectangles()

	$("#PRIOR_SILO_day1").click ->
		if PRIOR_SILO_day_dict[1][1] == 0
			PRIOR_SILO_day_dict[1][0].attr("fill", "blue")
			PRIOR_SILO_day_dict[1][1] = 1

		else if PRIOR_SILO_day_dict[1][1] == 1
			PRIOR_SILO_day_dict[1][0].attr("fill", "#d6d6d6")
			PRIOR_SILO_day_dict[1][1] = 0

		PRIOR_SILO_day_box_pct_fn()

		PRIOR_SILO_p_rain_value = PRIOR_SILO_day_box_value
		$('#PRIOR_SILO_p_rain').val(PRIOR_SILO_p_rain_value)

		PRIOR_SILO_pixel_updater()
		PRIOR_SILO_draw_boxprob_rectangles()

	$("#PRIOR_SILO_day2").click ->
		if PRIOR_SILO_day_dict[2][1] == 0
			PRIOR_SILO_day_dict[2][0].attr("fill", "blue")
			PRIOR_SILO_day_dict[2][1] = 1

		else if PRIOR_SILO_day_dict[2][1] == 1
			PRIOR_SILO_day_dict[2][0].attr("fill", "#d6d6d6")
			PRIOR_SILO_day_dict[2][1] = 0

		PRIOR_SILO_day_box_pct_fn()

		PRIOR_SILO_p_rain_value = PRIOR_SILO_day_box_value
		$('#PRIOR_SILO_p_rain').val(PRIOR_SILO_p_rain_value)

		PRIOR_SILO_pixel_updater()
		PRIOR_SILO_draw_boxprob_rectangles()

	$("#PRIOR_SILO_day3").click ->
		if PRIOR_SILO_day_dict[3][1] == 0
			PRIOR_SILO_day_dict[3][0].attr("fill", "blue")
			PRIOR_SILO_day_dict[3][1] = 1

		else if PRIOR_SILO_day_dict[3][1] == 1
			PRIOR_SILO_day_dict[3][0].attr("fill", "#d6d6d6")
			PRIOR_SILO_day_dict[3][1] = 0

		PRIOR_SILO_day_box_pct_fn()

		PRIOR_SILO_p_rain_value = PRIOR_SILO_day_box_value
		$('#PRIOR_SILO_p_rain').val(PRIOR_SILO_p_rain_value)

		PRIOR_SILO_pixel_updater()
		PRIOR_SILO_draw_boxprob_rectangles()

	$("#PRIOR_SILO_day4").click ->
		if PRIOR_SILO_day_dict[4][1] == 0
			PRIOR_SILO_day_dict[4][0].attr("fill", "blue")
			PRIOR_SILO_day_dict[4][1] = 1

		else if PRIOR_SILO_day_dict[4][1] == 1
			PRIOR_SILO_day_dict[4][0].attr("fill", "#d6d6d6")
			PRIOR_SILO_day_dict[4][1] = 0

		PRIOR_SILO_day_box_pct_fn()
		PRIOR_SILO_p_rain_value = PRIOR_SILO_day_box_value
		$('#PRIOR_SILO_p_rain').val(PRIOR_SILO_p_rain_value)

		PRIOR_SILO_pixel_updater()
		PRIOR_SILO_draw_boxprob_rectangles()

	PRIOR_SILO_recolor_day_box = ->
		for i in [0..PRIOR_SILO_num_days-1]
			if PRIOR_SILO_day_dict[i][1] == 1
				PRIOR_SILO_day_dict[i][0].attr("fill", "blue")


	# when p_rain is keypressed, updates the calendar
	# run this every time (1) KEYPRESS or (2) DRAG* changes
	PRIOR_SILO_calendar_update = ->

		colored_stack = []
		white_stack = []
		correct_colored_box_number = 0
		intvl_tuple_arr = []

		interval = 100/PRIOR_SILO_num_days
		cur_start = 0
		cur_end = interval

		stack_generator = ->
			colored_stack = []
			white_stack = []

			for i in [0..PRIOR_SILO_day_dict.length-1]
				if PRIOR_SILO_day_dict[i][1] == 1
					colored_stack.push i
				else if PRIOR_SILO_day_dict[i][1] == 0
					white_stack.push i	

		# properly produce intvl_tuple_arr
		for i in [0..PRIOR_SILO_num_days-1]
			intvl_tuple_arr.push [cur_start, cur_end, i+1]
			cur_start += interval
			cur_end += interval

		# updates correct_colored_box_number
		return_correct_colored_boxes = ->
			for i in [0..PRIOR_SILO_num_days-1]
				if PRIOR_SILO_p_rain_value > intvl_tuple_arr[i][0] && PRIOR_SILO_p_rain_value <= intvl_tuple_arr[i][1]
					correct_colored_box_number = intvl_tuple_arr[i][2]
					break # stop after updated correct_colored_box_number


			# if PRIOR_SILO_p_rain_value > intvl_tuple_arr[0][0] && PRIOR_SILO_p_rain_value <= intvl_tuple_arr[0][1]
			# 	correct_colored_box_number = intvl_tuple_arr[0][2]
			
			# else if PRIOR_SILO_p_rain_value > intvl_tuple_arr[1][0] && PRIOR_SILO_p_rain_value <= intvl_tuple_arr[1][1]
			# 	correct_colored_box_number = intvl_tuple_arr[1][2]
			
			# else if PRIOR_SILO_p_rain_value > intvl_tuple_arr[2][0] && PRIOR_SILO_p_rain_value <= intvl_tuple_arr[2][1]
			# 	correct_colored_box_number = intvl_tuple_arr[2][2]
			
			# else if PRIOR_SILO_p_rain_value > intvl_tuple_arr[3][0] && PRIOR_SILO_p_rain_value <= intvl_tuple_arr[3][1]
			# 	console.log("if 4", intvl_tuple_arr[4][2])
			# 	correct_colored_box_number = intvl_tuple_arr[3][2]

			# else if PRIOR_SILO_p_rain_value > intvl_tuple_arr[4][0] && PRIOR_SILO_p_rain_value <= intvl_tuple_arr[4][1]
			# 	correct_colored_box_number = intvl_tuple_arr[4][2]

			#console.log("correct_colored_box_number", correct_colored_box_number)


		stack_generator()
		return_correct_colored_boxes()
		

		for i in [0..PRIOR_SILO_num_days-1]
			while colored_stack.length != correct_colored_box_number
				if colored_stack.length < correct_colored_box_number && white_stack.length > 0
					# color blocks appropriately
					x = white_stack.pop()

					PRIOR_SILO_day_dict[x][0].attr("fill", "blue") #superficial
					PRIOR_SILO_day_dict[x][1] = 1

				else if colored_stack.length > correct_colored_box_number && colored_stack.length > 0
					# color blocks appropriately
					x = colored_stack.pop()
					PRIOR_SILO_day_dict[x][0].attr("fill", "grey")
					PRIOR_SILO_day_dict[x][1] = 0
				else
					break

			stack_generator()


	# calculates what percent of days are colored in
	PRIOR_SILO_day_box_pct_fn = ->
		counter = 0

		for i in [0..PRIOR_SILO_day_dict.length-1]
			if PRIOR_SILO_day_dict[i][1] == 1
				counter += 1

		PRIOR_SILO_day_box_value = (counter/PRIOR_SILO_day_dict.length)*100


	# ██████╗  ██████╗ ██╗  ██╗    ██████╗  █████╗ ██╗   ██╗███████╗
	# ██╔══██╗██╔═══██╗╚██╗██╔╝    ██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝
	# ██████╔╝██║   ██║ ╚███╔╝     ██║  ██║███████║ ╚████╔╝ ███████╗
	# ██╔══██╗██║   ██║ ██╔██╗     ██║  ██║██╔══██║  ╚██╔╝  ╚════██║
	# ██████╔╝╚██████╔╝██╔╝ ██╗    ██████╔╝██║  ██║   ██║   ███████║
	# ╚═════╝  ╚═════╝ ╚═╝  ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝

	# - - - - - - - - - - BOX DAYS - - - - - - - - - -

	## HIGH LEVEL

	# Create box days

	# Establish relationship between box days and:
		# 1) Probability input
		# 2) Box itself.

	# and reverse compatibility

	# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

	# Declare variables

	# Bind a div object to an SVG container
	svgContainer_boxDays = d3.select("#area_boxDays").append("svg")

	# Define variables
	num_days = 5
	day_dict = []
	daybox_size = 30
	x_multiplier = 30

	# Append an individual box to the SVG container
	daybox_rect_generator = ->
		for i in [0..num_days-1]
			day_dict[i] = [svgContainer_boxDays.append("rect"), 0]
			#console.log("yo", day_dict[i])
	
	daybox_rect_generator()

	draw_concreteprob_rectangles = ->
		for i in [0..num_days-1]
			make_rect(day_dict[i][0],
				x: x_multiplier
				y: 30
				width: daybox_size
				height: daybox_size
				fill: "#d6d6d6"
				opacity: 0.8
				id: "day" + i)

			x_multiplier = x_multiplier+33

	draw_concreteprob_rectangles()

	day_box_value = 0

	## - - - - - - - - - - ATTEMPT TO RE-FACTOR CLICKING

	'''
	click_fn_for_days = ->
		for i in [0..num_days-1]
			console.log("i in num days.", i)
			$("#day" + i).click ->
				console.log("BREAKBREAK2222")
				if day_dict[i][1] == 0
					console.log("BREAKBREAK3333")
					day_dict[i][0].attr("fill", "red")
					day_dict[i][1] = 1

				else if day_dict[i][1] == 1
					console.log("BREAKBREAK4444")
					day_dict[i][0].attr("fill", "#d6d6d6")
					day_dict[i][1] = 0

		# generates "day_box_value" (i.e. which days are colored in)
		day_box_pct_fn()

		# updates p_rain_value correctly
		p_rain_value = day_box_value

		# updates p_rain_value [display] correctly
		$('#p_rain').val(p_rain_value)

		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

	# run it!
	click_fn_for_days()

	'''
	$("#day0").click ->
		if day_dict[0][1] == 0
			day_dict[0][0].attr("fill", "red")
			day_dict[0][1] = 1

		else if day_dict[0][1] == 1
			day_dict[0][0].attr("fill", "#d6d6d6")
			day_dict[0][1] = 0

		day_box_pct_fn()
		p_rain_value = day_box_value
		$('#p_rain').val(p_rain_value)

		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

	$("#day1").click ->
		if day_dict[1][1] == 0
			day_dict[1][0].attr("fill", "red")
			day_dict[1][1] = 1

		else if day_dict[1][1] == 1
			day_dict[1][0].attr("fill", "#d6d6d6")
			day_dict[1][1] = 0

		day_box_pct_fn()

		p_rain_value = day_box_value
		$('#p_rain').val(p_rain_value)

		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

	$("#day2").click ->
		if day_dict[2][1] == 0
			day_dict[2][0].attr("fill", "red")
			day_dict[2][1] = 1

		else if day_dict[2][1] == 1
			day_dict[2][0].attr("fill", "#d6d6d6")
			day_dict[2][1] = 0

		day_box_pct_fn()

		p_rain_value = day_box_value
		$('#p_rain').val(p_rain_value)

		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

	$("#day3").click ->
		if day_dict[3][1] == 0
			day_dict[3][0].attr("fill", "red")
			day_dict[3][1] = 1

		else if day_dict[3][1] == 1
			day_dict[3][0].attr("fill", "#d6d6d6")
			day_dict[3][1] = 0

		day_box_pct_fn()

		p_rain_value = day_box_value
		$('#p_rain').val(p_rain_value)

		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

	$("#day4").click ->
		if day_dict[4][1] == 0
			day_dict[4][0].attr("fill", "red")
			day_dict[4][1] = 1

		else if day_dict[4][1] == 1
			day_dict[4][0].attr("fill", "#d6d6d6")
			day_dict[4][1] = 0

		day_box_pct_fn()
		p_rain_value = day_box_value
		$('#p_rain').val(p_rain_value)

		pixel_updater()
		draw_boxprob_rectangles()
		draw_beamprob_rectangles()

	recolor_day_box = ->
		for i in [0..num_days-1]
			if day_dict[i][1] == 1
				day_dict[i][0].attr("fill", "blue")


	# when p_rain is keypressed, updates the calendar
	# run this every time (1) KEYPRESS or (2) DRAG* changes
	calendar_update = ->

		colored_stack = []
		white_stack = []
		correct_colored_box_number = 0
		intvl_tuple_arr = []

		interval = 100/num_days
		cur_start = 0
		cur_end = interval

		stack_generator = ->
			colored_stack = []
			white_stack = []

			for i in [0..day_dict.length-1]
				if day_dict[i][1] == 1
					colored_stack.push i
				else if day_dict[i][1] == 0
					white_stack.push i	

		# properly produce intvl_tuple_arr
		for i in [0..num_days-1]
			intvl_tuple_arr.push [cur_start, cur_end, i+1]
			cur_start += interval
			cur_end += interval

			console.log(intvl_tuple_arr[i])

		return_correct_colored_boxes = ->
			#console.log("YO", p_rain_value)

			if p_rain_value > intvl_tuple_arr[0][0] && p_rain_value <= intvl_tuple_arr[0][1]
				console.log("if 1", intvl_tuple_arr[1][2])
				correct_colored_box_number = intvl_tuple_arr[0][2]
				console.log("correct_colored_box_number", correct_colored_box_number)
			
			else if p_rain_value > intvl_tuple_arr[1][0] && p_rain_value <= intvl_tuple_arr[1][1]
				console.log("if 2", intvl_tuple_arr[2][2])
				correct_colored_box_number = intvl_tuple_arr[1][2]
				console.log("correct_colored_box_number", correct_colored_box_number)
			
			else if p_rain_value > intvl_tuple_arr[2][0] && p_rain_value <= intvl_tuple_arr[2][1]
				console.log("if 3", intvl_tuple_arr[3][2])
				correct_colored_box_number = intvl_tuple_arr[2][2]
			
			else if p_rain_value > intvl_tuple_arr[3][0] && p_rain_value <= intvl_tuple_arr[3][1]
				console.log("if 4", intvl_tuple_arr[4][2])
				correct_colored_box_number = intvl_tuple_arr[3][2]

			else if p_rain_value > intvl_tuple_arr[4][0] && p_rain_value <= intvl_tuple_arr[4][1]
				correct_colored_box_number = intvl_tuple_arr[4][2]


		stack_generator()
		return_correct_colored_boxes()
		

		for i in [0..num_days-1]

			#console.log("i", i)
			#console.log("correct_colored_box_number", correct_colored_box_number)
			#console.log("colored_stack.length", colored_stack.length)


			while colored_stack.length != correct_colored_box_number
				if colored_stack.length < correct_colored_box_number && white_stack.length > 0
					# color blocks appropriately
					x = white_stack.pop()
					#console.log("colored_stack.length < correct_colored_box_number", white_stack.length, x)

					day_dict[x][0].attr("fill", "blue") #superficial
					day_dict[x][1] = 1

				else if colored_stack.length > correct_colored_box_number && colored_stack.length > 0
					# color blocks appropriately
					#console.log("colored_stack.length > correct_colored_box_number")
					x = colored_stack.pop()
					day_dict[x][0].attr("fill", "grey")
					day_dict[x][1] = 0

				else
					break

			stack_generator()


	# calculates what percent of days are colored in
	day_box_pct_fn = ->
		counter = 0

		for i in [0..day_dict.length-1]
			if day_dict[i][1] == 1
				counter += 1

		day_box_value = (counter/day_dict.length)*100
















	# - - - - - - - - - - - - - -  EVIDENCE SILO

	# Evidence Silo for BOX-PROB

	EVIDENCE_SILO_square_size = 300
	EVIDENCE_SILO_xCoord = 0
	EVIDENCE_SILO_yCoord = 0

	EVIDENCE_SILO_p_rain_value = 0
	EVIDENCE_SILO_p_rain_value_PX = 0

	svgContainer_box_EVIDENCE_SILO = d3.select("#area_for_boxprob_EVIDENCE_SILO")
									.append("svg")
									.attr("width", "300").attr("height", "100%")

	console.log("/////")
	console.log(svgContainer_box_EVIDENCE_SILO)

	EVIDENCE_SILO_base_rect = svgContainer_box_EVIDENCE_SILO.append("rect")
	EVIDENCE_SILO_rect_p_rain = svgContainer_box_EVIDENCE_SILO.append("rect")

	EVIDENCE_SILO_dragger_p_rain = svgContainer_box_EVIDENCE_SILO.append("rect")

	EVIDENCE_SILO_draw_boxprob_base = ->
		make_rect(EVIDENCE_SILO_base_rect,
			x: EVIDENCE_SILO_xCoord
			y: EVIDENCE_SILO_yCoord
			width: EVIDENCE_SILO_square_size
			height: EVIDENCE_SILO_square_size
			fill: "#ffa9aa"
			opacity: 0.8
			id: "EVIDENCE_SILO_base_rect")

	# Define opacity to make the box darker as we drag
	EVIDENCE_SILO_rect_p_rain_opacity = 1

	EVIDENCE_SILO_draw_boxprob_rectangles = ->
		# Rectangles
		make_rect(EVIDENCE_SILO_rect_p_rain,
			x: EVIDENCE_SILO_xCoord
			y: EVIDENCE_SILO_yCoord
			width: EVIDENCE_SILO_p_rain_value_PX
			height: EVIDENCE_SILO_square_size
			fill: "#e44547"
			opacity: 0.8
			id: "EVIDENCE_SILO_rect_p_rain")

		# Dragger
		make_rect(EVIDENCE_SILO_dragger_p_rain,
			x: EVIDENCE_SILO_p_rain_value_PX
			y: EVIDENCE_SILO_yCoord
			width: 5
			height: EVIDENCE_SILO_square_size
			fill: "#b80b00"
			opacity: 1
			id: "EVIDENCE_SILO_dragger_p_rain")

	# Dragging methods
	EVIDENCE_SILO_drag_rain_xCoord = 0

	EVIDENCE_SILO_on_drag_rain = (d) ->

		EVIDENCE_SILO_drag_rain_xCoord = d3.event.x
		yCoord = d3.event.y
		EVIDENCE_SILO_p_rain_value = (EVIDENCE_SILO_drag_rain_xCoord/EVIDENCE_SILO_square_size)*100
		EVIDENCE_SILO_p_rain_value = Math.round(EVIDENCE_SILO_p_rain_value)

		# Clamp: takes the bigger of the two values
		EVIDENCE_SILO_p_rain_value = Math.min(EVIDENCE_SILO_p_rain_value, 100)
		EVIDENCE_SILO_p_rain_value = Math.max(0, EVIDENCE_SILO_p_rain_value)

		$('#EVIDENCE_SILO_p_rain').val(EVIDENCE_SILO_p_rain_value)

		EVIDENCE_SILO_text_label_move()
		EVIDENCE_SILO_pixel_updater()
		EVIDENCE_SILO_draw_boxprob_rectangles()
		EVIDENCE_SILO_calendar_update()

	EVIDENCE_SILO_draw_boxprob_base()

	EVIDENCE_SILO_drag_rain = d3.behavior.drag()
								.on("drag", EVIDENCE_SILO_on_drag_rain)

	EVIDENCE_SILO_dragger_p_rain.call(EVIDENCE_SILO_drag_rain)

	# User input

	$('#EVIDENCE_SILO_p_rain').keyup ->
		EVIDENCE_SILO_p_rain_value = $('#EVIDENCE_SILO_p_rain').val()

		EVIDENCE_SILO_pixel_updater()
		EVIDENCE_SILO_calendar_update()

		EVIDENCE_SILO_draw_boxprob_rectangles()

	EVIDENCE_SILO_pixel_updater = ->
		$('#EVIDENCE_SILO_p_rain_NOT').val(100-EVIDENCE_SILO_p_rain_value)
		EVIDENCE_SILO_p_rain_value_PX = (EVIDENCE_SILO_p_rain_value*EVIDENCE_SILO_square_size)/100		

	EVIDENCE_SILO_text_label_move = ->
		# p_rain
		$('#EVIDENCE_SILO_p_rain_div').css({
			left: Math.max(0, Math.min(EVIDENCE_SILO_drag_rain_xCoord - 55,300))
			})

	# - - - - - - - [ EVIDENCE_SILO ] BOX DAYS - - - - - - - - - -

	# Need to take care of "pixel_updater"


	#discrete_prob_creator(svgContainerID, divID, link_to_BayesianBoxID, numOfSquares)

	#discrete_prob_creator(EVIDENCE_SILO_svgContainer_boxDays, EVIDENCE_SILO_area_boxDays, 5, EVIDENCE_SILO_p_rain_value)


	EVIDENCE_SILO_svgContainer_boxDays = d3.select("#EVIDENCE_SILO_area_boxDays").append("svg")

	EVIDENCE_SILO_num_days = 6
	EVIDENCE_SILO_day_dict = []
	EVIDENCE_SILO_daybox_size = 30

	EVIDENCE_SILO_x_multiplier = 30 # ???

	# draw all the individual squares
		# data structure: [RECTANGLE_NAME, O IF BLANK / 1 IF SHADED]
	EVIDENCE_SILO_daybox_rect_generator = ->
		for i in [0..EVIDENCE_SILO_num_days-1]
			EVIDENCE_SILO_day_dict[i] = [EVIDENCE_SILO_svgContainer_boxDays.append("rect"), 0]

	EVIDENCE_SILO_daybox_rect_generator()

	# make all the rectangles and put them in day_dict
	EVIDENCE_SILO_draw_concreteprob_rectangles = ->
		for i in [0..EVIDENCE_SILO_num_days-1]
			make_rect(EVIDENCE_SILO_day_dict[i][0],
				x: EVIDENCE_SILO_x_multiplier
				y: 30
				width: EVIDENCE_SILO_daybox_size
				height: EVIDENCE_SILO_daybox_size
				fill: "#d6d6d6"
				opacity: 0.5
				id: "EVIDENCE_SILO_day" + i)

			EVIDENCE_SILO_x_multiplier = EVIDENCE_SILO_x_multiplier+33

		console.log("START")
		text1 = EVIDENCE_SILO_svgContainer_boxDays.append("text")
												.attr("x", 42)
												.attr("y", 47)
												.text(".")
												.attr("fill", "black")
												.attr("stroke", "black")

		text2 = EVIDENCE_SILO_svgContainer_boxDays.append("text")
												.attr("x", 122)
												.attr("y", 37)
												.attr("fill", "black")
												.attr("stroke", "black")
												# dot 1
												.append("tspan")
												.text(".")
												.attr("dy", 6)
												.attr("x", 76)
												#dot 2
												.append("tspan")
												.text(".")
												.attr("dy", 6)
												.attr("x", 76)


		text3 = EVIDENCE_SILO_svgContainer_boxDays.append("text")
												.attr("x", 122)
												.attr("y", 37)
												.attr("fill", "black")
												.attr("stroke", "black")
												# dot 1
												.append("tspan")
												.text("  .")
												.attr("dy", 6)
												.attr("x", 106)
												#dot 2
												.append("tspan")
												.text("..")
												.attr("dy", 6)
												.attr("x", 106)

		text4 = EVIDENCE_SILO_svgContainer_boxDays.append("text")
												.attr("x", 122)
												.attr("y", 37)
												.attr("fill", "black")
												.attr("stroke", "black")
												# dot 1
												.append("tspan")
												.text("..")
												.attr("dy", 6)
												.attr("x", 138)
												#dot 2
												.append("tspan")
												.text("..")
												.attr("dy", 6)
												.attr("x", 138)

		text5 = EVIDENCE_SILO_svgContainer_boxDays.append("text")
												.attr("x", 122)
												.attr("y", 37)
												.attr("fill", "black")
												.attr("stroke", "black")
												# dot 1
												.append("tspan")
												.text(". .")
												.attr("dy", 4)
												.attr("x", 170)
												#dot 2
												.append("tspan")
												.text("  .")
												.attr("dy", 4)
												.attr("x", 170)
												#dot 3
												.append("tspan")
												.text(". .")
												.attr("dy", 5)
												.attr("x", 170)

		text6 = EVIDENCE_SILO_svgContainer_boxDays.append("text")
												.attr("x", 122)
												.attr("y", 37)
												.attr("fill", "black")
												.attr("stroke", "black")
												# dot 1
												.append("tspan")
												.text("...")
												.attr("dy", 4)
												.attr("x", 201)
												#dot 2
												.append("tspan")
												.text("...")
												.attr("dy", 5)
												.attr("x", 201)
												

	EVIDENCE_SILO_draw_concreteprob_rectangles()

	EVIDENCE_SILO_day_box_value = 0

	$("#EVIDENCE_SILO_day0").click ->
		if EVIDENCE_SILO_day_dict[0][1] == 0
			EVIDENCE_SILO_day_dict[0][0].attr("fill", "blue")
			EVIDENCE_SILO_day_dict[0][1] = 1

		else if EVIDENCE_SILO_day_dict[0][1] == 1
			EVIDENCE_SILO_day_dict[0][0].attr("fill", "#d6d6d6")
			EVIDENCE_SILO_day_dict[0][1] = 0

		EVIDENCE_SILO_day_box_pct_fn()
		EVIDENCE_SILO_p_rain_value =  Math.round(EVIDENCE_SILO_day_box_value)
		$('#EVIDENCE_SILO_p_rain').val(EVIDENCE_SILO_p_rain_value)

		EVIDENCE_SILO_pixel_updater()
		EVIDENCE_SILO_draw_boxprob_rectangles()

	$("#EVIDENCE_SILO_day1").click ->
		if EVIDENCE_SILO_day_dict[1][1] == 0
			EVIDENCE_SILO_day_dict[1][0].attr("fill", "blue")
			EVIDENCE_SILO_day_dict[1][1] = 1

		else if EVIDENCE_SILO_day_dict[1][1] == 1
			EVIDENCE_SILO_day_dict[1][0].attr("fill", "#d6d6d6")
			EVIDENCE_SILO_day_dict[1][1] = 0

		EVIDENCE_SILO_day_box_pct_fn()

		EVIDENCE_SILO_p_rain_value =  Math.round(EVIDENCE_SILO_day_box_value)
		$('#EVIDENCE_SILO_p_rain').val(EVIDENCE_SILO_p_rain_value)

		EVIDENCE_SILO_pixel_updater()
		EVIDENCE_SILO_draw_boxprob_rectangles()

	$("#EVIDENCE_SILO_day2").click ->
		if EVIDENCE_SILO_day_dict[2][1] == 0
			EVIDENCE_SILO_day_dict[2][0].attr("fill", "blue")
			EVIDENCE_SILO_day_dict[2][1] = 1

		else if EVIDENCE_SILO_day_dict[2][1] == 1
			EVIDENCE_SILO_day_dict[2][0].attr("fill", "#d6d6d6")
			EVIDENCE_SILO_day_dict[2][1] = 0

		EVIDENCE_SILO_day_box_pct_fn()

		EVIDENCE_SILO_p_rain_value =  Math.round(EVIDENCE_SILO_day_box_value)
		$('#EVIDENCE_SILO_p_rain').val(EVIDENCE_SILO_p_rain_value)

		EVIDENCE_SILO_pixel_updater()
		EVIDENCE_SILO_draw_boxprob_rectangles()

	$("#EVIDENCE_SILO_day3").click ->
		if EVIDENCE_SILO_day_dict[3][1] == 0
			EVIDENCE_SILO_day_dict[3][0].attr("fill", "blue")
			EVIDENCE_SILO_day_dict[3][1] = 1

		else if EVIDENCE_SILO_day_dict[3][1] == 1
			EVIDENCE_SILO_day_dict[3][0].attr("fill", "#d6d6d6")
			EVIDENCE_SILO_day_dict[3][1] = 0

		EVIDENCE_SILO_day_box_pct_fn()

		EVIDENCE_SILO_p_rain_value =  Math.round(EVIDENCE_SILO_day_box_value)
		$('#EVIDENCE_SILO_p_rain').val(EVIDENCE_SILO_p_rain_value)

		EVIDENCE_SILO_pixel_updater()
		EVIDENCE_SILO_draw_boxprob_rectangles()

	$("#EVIDENCE_SILO_day4").click ->
		if EVIDENCE_SILO_day_dict[4][1] == 0
			EVIDENCE_SILO_day_dict[4][0].attr("fill", "blue")
			EVIDENCE_SILO_day_dict[4][1] = 1

		else if EVIDENCE_SILO_day_dict[4][1] == 1
			EVIDENCE_SILO_day_dict[4][0].attr("fill", "#d6d6d6")
			EVIDENCE_SILO_day_dict[4][1] = 0

		EVIDENCE_SILO_day_box_pct_fn()
		EVIDENCE_SILO_p_rain_value =  Math.round(EVIDENCE_SILO_day_box_value)
		$('#EVIDENCE_SILO_p_rain').val(EVIDENCE_SILO_p_rain_value)

		EVIDENCE_SILO_pixel_updater()
		EVIDENCE_SILO_draw_boxprob_rectangles()

	$("#EVIDENCE_SILO_day5").click ->
		if EVIDENCE_SILO_day_dict[5][1] == 0
			EVIDENCE_SILO_day_dict[5][0].attr("fill", "blue")
			EVIDENCE_SILO_day_dict[5][1] = 1

		else if EVIDENCE_SILO_day_dict[5][1] == 1
			EVIDENCE_SILO_day_dict[5][0].attr("fill", "#d6d6d6")
			EVIDENCE_SILO_day_dict[5][1] = 0

		EVIDENCE_SILO_day_box_pct_fn()
		EVIDENCE_SILO_p_rain_value =  Math.round(EVIDENCE_SILO_day_box_value)
		$('#EVIDENCE_SILO_p_rain').val(EVIDENCE_SILO_p_rain_value)

		EVIDENCE_SILO_pixel_updater()
		EVIDENCE_SILO_draw_boxprob_rectangles()

	EVIDENCE_SILO_recolor_day_box = ->
		for i in [0..EVIDENCE_SILO_num_days-1]
			if EVIDENCE_SILO_day_dict[i][1] == 1
				EVIDENCE_SILO_day_dict[i][0].attr("fill", "blue")


	# when p_rain is keypressed, updates the calendar
	# run this every time (1) KEYPRESS or (2) DRAG* changes
	EVIDENCE_SILO_calendar_update = ->

		colored_stack = []
		white_stack = []
		correct_colored_box_number = 0
		intvl_tuple_arr = []

		interval = 100/EVIDENCE_SILO_num_days
		cur_start = 0
		cur_end = interval

		stack_generator = ->
			colored_stack = []
			white_stack = []

			for i in [0..EVIDENCE_SILO_day_dict.length-1]
				if EVIDENCE_SILO_day_dict[i][1] == 1
					colored_stack.push i
				else if EVIDENCE_SILO_day_dict[i][1] == 0
					white_stack.push i	

		# properly produce intvl_tuple_arr
		for i in [0..EVIDENCE_SILO_num_days-1]
			intvl_tuple_arr.push [cur_start, cur_end, i+1]
			cur_start += interval
			cur_end += interval

		# updates correct_colored_box_number
		return_correct_colored_boxes = ->
			for i in [0..EVIDENCE_SILO_num_days-1]
				if EVIDENCE_SILO_p_rain_value > intvl_tuple_arr[i][0] && EVIDENCE_SILO_p_rain_value <= intvl_tuple_arr[i][1]
					correct_colored_box_number = intvl_tuple_arr[i][2]
					break # stop after updated correct_colored_box_number


			# if EVIDENCE_SILO_p_rain_value > intvl_tuple_arr[0][0] && EVIDENCE_SILO_p_rain_value <= intvl_tuple_arr[0][1]
			# 	correct_colored_box_number = intvl_tuple_arr[0][2]
			
			# else if EVIDENCE_SILO_p_rain_value > intvl_tuple_arr[1][0] && EVIDENCE_SILO_p_rain_value <= intvl_tuple_arr[1][1]
			# 	correct_colored_box_number = intvl_tuple_arr[1][2]
			
			# else if EVIDENCE_SILO_p_rain_value > intvl_tuple_arr[2][0] && EVIDENCE_SILO_p_rain_value <= intvl_tuple_arr[2][1]
			# 	correct_colored_box_number = intvl_tuple_arr[2][2]
			
			# else if EVIDENCE_SILO_p_rain_value > intvl_tuple_arr[3][0] && EVIDENCE_SILO_p_rain_value <= intvl_tuple_arr[3][1]
			# 	console.log("if 4", intvl_tuple_arr[4][2])
			# 	correct_colored_box_number = intvl_tuple_arr[3][2]

			# else if EVIDENCE_SILO_p_rain_value > intvl_tuple_arr[4][0] && EVIDENCE_SILO_p_rain_value <= intvl_tuple_arr[4][1]
			# 	correct_colored_box_number = intvl_tuple_arr[4][2]

			#console.log("correct_colored_box_number", correct_colored_box_number)


		stack_generator()
		return_correct_colored_boxes()
		

		for i in [0..EVIDENCE_SILO_num_days-1]
			while colored_stack.length != correct_colored_box_number
				if colored_stack.length < correct_colored_box_number && white_stack.length > 0
					# color blocks appropriately
					x = white_stack.pop()

					EVIDENCE_SILO_day_dict[x][0].attr("fill", "blue") #superficial
					EVIDENCE_SILO_day_dict[x][1] = 1

				else if colored_stack.length > correct_colored_box_number && colored_stack.length > 0
					# color blocks appropriately
					x = colored_stack.pop()
					EVIDENCE_SILO_day_dict[x][0].attr("fill", "grey")
					EVIDENCE_SILO_day_dict[x][1] = 0
				else
					break

			stack_generator()


	# calculates what percent of days are colored in
	EVIDENCE_SILO_day_box_pct_fn = ->
		counter = 0

		for i in [0..EVIDENCE_SILO_day_dict.length-1]
			if EVIDENCE_SILO_day_dict[i][1] == 1
				counter += 1

		EVIDENCE_SILO_day_box_value = (counter/EVIDENCE_SILO_day_dict.length)*100


	
