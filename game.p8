pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
--main
act_update = nil
act_draw = nil
game_title = "games-title"

cartdata(game_title)

function _init() 
    open_menu()
end

function _update()
    act_update()
end

function _draw()
    cls()
    act_draw()
end

-->8
--main-menu

local title_y = 32
local selections = {
    "play",
    "highscore",
}
local cur_sel = 1

function open_menu() 
    act_update = udpate_menu
    act_draw = draw_menu
end

function udpate_menu()
    if btn(❎) then
        if cur_sel == 1 then
            open_game()
        end

        if cur_sel == 2 then
            open_highscore()
        end
    end
    
    if btnp(⬆️) then cur_sel = wrap_int(cur_sel, 1, 2, 1) end
    if btnp(⬇️) then cur_sel = wrap_int(cur_sel, 1, 2, -1) end
end

function draw_menu()
    rect(0,0,127,127,1)
    outline_print(game_title, 64 - #game_title*4 / 2, title_y, 7, 5, 1)
    rectfill(32,title_y+7,98,title_y+7,7)
    rectfill(31,title_y+8,97,title_y+9,5)

    print("by MaGeJo", 24, title_y+14, 5)
    print("by MaGeJo", 23, title_y+13, 7)

    rectfill(73, title_y+12, 103, title_y+18, 8)
    print("gmtk-22", 75, title_y+13, 0)

    draw_selection();

    print("www.switchcase.ch", 3, 120, 11)
end

function draw_selection() 
    for i=1, #selections do
        local pre = "   "
        if cur_sel == i then pre="❎ " end
        print(pre..selections[i], 24, title_y+28+(i-1)*9, 11)
    end
end

-->8
--game
local score = 0

function open_game() 
    score = 0
    act_update = update_game
    act_draw = draw_game
    init_particles()
end

function update_game() 
    if btnp(❎) then 
        score += 1
    particle_burst({x=63, y=40},5,0.5,nil,3,10) 
    end

    if btnp(🅾️) then 
        add_highscore(score)
        open_menu()
    end
    update_particles()
end

function draw_game() 
    
    print_center("score: "..score, 64, 7)
    draw_particles()
    print("press: ❎ to score", 0, 0, 7)
    print("🅾️ to submit score & back", 0, 120, 10)
end

-->8
--highscore
function open_highscore() 
    get_highscore()
    act_update = update_hs
    act_draw = draw_hs
end

function update_hs() 
    if btnp(🅾️) then open_menu() end
end

function draw_hs() 
    print("highscores:", 0, 0, 7)

    for i=1, #highscores do 
        print(""..highscores[i], 4, 12 + (i-1)*7, 7);
    end 

    print("back to menu 🅾️", 4, 123, 7);
end

-->8
--tools

function print_center(str, y, col)
    print(str, 64 - #str*4 / 2, y, col)
end

function outline_print(str, x, y, col, out_col, weight)
    if not weight then weight = 1 end 
    for _x=-weight, weight do
        for _y=-weight, weight do
            print(str, x+_x, y+_y, out_col)
        end        
    end
    print(str, x, y, col)      
end

function wrap_int(int, min_i, max_i, add_i)
	if not add_i then add_i = 0 end
	local new_i = int+add_i
	if new_i < min_i then return max_i end  
	if new_i > max_i then return min_i end
	return new_i
end

-->8
--local highscore--
//read hs from local storage
//1. get_highscore()
//2. for i=1, #highscores do 
//    print(""..highscores[i]
//			end 

//add new highscore
//1. add_highscore(player.score)



highscores={	
	0,0,0,0,0,0,0,0,0,0
}

last_highscore = -1

//loads all hs from storage
function get_highscore()
	for i=1, #highscores do
		highscores[i]=dget(i)
	end
	last_highscore = dget(#highscores+1)
end

//delete all hiscores
function delete_hightscore()
	for i=1, #highscores do
		highscores[i]=0
		dset(i,0)
	end
end

//save hs to storage
function save_highscore()
	for i=1, #highscores do
		dset(i,highscores[i])
	end
	dset(#highscores+1,last_highscore)
end

//1. add new highscore,
//2. sort (1 = highest)
//3. store localy
function add_highscore(score)
	last_highscore = score
	for i=1, #highscores do
		local temp = highscores[i]
		if score > highscores[i] then
			highscores[i] = score
			score = temp
		end
	end
	save_highscore()
end

-->8
--particle system--

particlebuffer = {}
max_particles = 50
act_index = 1

function init_particles()	
	particle_buffer = {}
	
	for i=1, max_particles do
		particle_buffer[i] = {
			life_t = 0
		}
	end
end

//nomofpar -> how many particles
//life_t -> alive time
//form -> 1: pixels, 2:circles, 3: rects
//size -> [1-max number] size of the particle
//col -> color of the particle
function particle_burst(pos,numofparticles,life_t,form,size,col,speed) 
	if numofparticles == nil then numofparticles = 1 end
	if life_t == nil then life_t = 3 end
	if form == nil then form = 0 end
	if size == nil then size = 1 end
	if col == nil then col = 7 end
	if speed == nil then speed = 1 end
	
	if form == 0 then form = flr(rnd(3)+1) end
	
	for i=1, numofparticles do
		particle_buffer[act_index].life_t = life_t
		particle_buffer[act_index].pos = {
			x = pos.x,
			y = pos.y		
		}
		particle_buffer[act_index].form = form
		particle_buffer[act_index].size = size
		particle_buffer[act_index].col = col
		particle_buffer[act_index].phy = phy
		particle_buffer[act_index].ang = 1/numofparticles * i
		particle_buffer[act_index].speed = speed
		act_index += 1
		if act_index > max_particles then
			act_index = 1
		end 
	end		
end



function update_particles()
	for i=1, max_particles do
		local part = particle_buffer[i]
		if part.life_t > 0 then
			part.life_t -= 1/30	
			part.pos.x += cos(part.ang)*part.speed
			part.pos.y += sin(part.ang)*part.speed
		end
	end 
end

function draw_particles()
	for i=1, max_particles do
		local part = particle_buffer[i]
		if part.life_t > 0 then
			local x = part.pos.x
			local y = part.pos.y
			if part.form == 1 then
				pset(x, y, part.col)
			elseif part.form == 2 then
				circfill(x, y, part.size, part.col)
			elseif part.form == 3 then
				rectfill(
					x,
					y,
					x + part.size,
					y + part.size,
					part.col
				)
			end
			
		end
	end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
