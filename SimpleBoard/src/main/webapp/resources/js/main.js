
var canvas = document.getElementById('canvas');
var ctx = canvas.getContext('2d');

canvas.width = window.innerWidth - 100;
canvas.height = window.innerHeight - 100;

var img1 = new Image();
img1.src = 'resources/pictures/chicken.png';

var dino = {
	x : 10,
	y : 200,
	width : 50,
	height: 50,
	draw(){
		ctx.fillStyle = 'green';
		ctx.fillRect(this.x,this.y, this.width,this.height);
		ctx.drawImage(img1, this.x , this.y);
	}
}

var img2 = new Image();
img2.src = 'resources/pictures/egg.png';

class Cactus{
	constructor(){
		this.x = 500;
		this.y = 200;
		this.width = 50;
		this.height = 50;
	}
	draw(){
		ctx.fillStyle = 'red';
		ctx.fillRect(this.x,this.y, this.width,this.height); // 히트박스
		ctx.drawImage(img2, this.x , this.y);
	}
}

var timer = 0;
var cactusMany = [];
var jumpTimer = 0;
var animation;

function frameStart(){
	animation = requestAnimationFrame(frameStart);
	timer ++;
	
	ctx.clearRect(0,0, canvas.width, canvas.height);
	
	/*모니터 주사율 따라 timer 숫자고치기  */ 
	if(timer % 200 === 0){
	var cactus = new Cactus();
	cactusMany.push(cactus);
	
	}
	
	cactusMany.forEach((a, i, o)=>{
		//x좌표가 0 미만이면 제거
		if(a.x < 0){
			o.splice(i,1);
		}
		a.x--;
		crash(dino, a);
		
		a.draw();
	})
	
	//cactus.draw();
	
	if(jumpButton == true){
		dino.y --;	
		jumpTimer++;
	}
	
	if(jumpButton == false){
		if(dino.y < 200){
			dino.y ++;	
		}
		
	}
	
	if(jumpTimer > 100){
		jumpButton = false;
		jumpTimer = 0;
	}
	
	dino.draw();
}

frameStart();

//층돌확인

function crash(dino, cactus){
	var xGap = cactus.x - (dino.x + dino.width);
	var yGap = cactus.y - (dino.y + dino.height);
	if( xGap < 0 && yGap <0){
		ctx.clearRect(0,0, canvas.width, canvas.height);
		cancelAnimationFrame(animation);
	}
}


var jumpButton = false;
document.addEventListener('keydown', function(e){
	if(e.code === 'Space'){
		jumpButton = true;
	}
})



