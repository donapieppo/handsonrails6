export class Hold {
  constructor(x, y, hold_type) {
    this.colors = { 'start': 'rgba(123, 123, 123, 0.9)', 
                    'top':   'rgba(123, 1, 123, 0.9)', 
                    'hold':  'rgba(123, 123, 1, 0.9)' };
    this.x = x;
    this.y = y;
    this.hold_type = hold_type;
  }

  color() {
    return this.colors[this.hold_type];
  }

  draw(ctx, width) {
    ctx.beginPath();
    ctx.lineWidth = "8";
    ctx.strokeStyle = this.color();
    ctx.arc(this.x, this.y, width, 0, 2 * Math.PI);
    ctx.closePath();
    ctx.stroke();

    //if (this.hold_type == 'start' || this.hold_type == 'top') {
      ctx.font = "16px Arial";
      ctx.fillText(this.hold_type, this.x + 30, this.y - 15); 
      ctx.fillText(this.x + ":" + this.y, this.x + 30, this.y + 15); 
      ctx.fillText(this.x + ":" + this.y, this.x - 80, this.y - 15); 
    //}
  }

  delete(ctx, x, y, width) {
  }
}

export class HoldPinner {

  constructor(img, width, height) {
    this.width = width;
    this.height = height;

    this.canvas = document.createElement('canvas');
    this.canvas.setAttribute('width', width);
    this.canvas.setAttribute('height', height);
    this.canvas.style.border = '2px solid blue';
    this.canvas.style.background = ("url('" + img + "')");
    this.canvas.setAttribute('id', 'canvas');
    document.getElementById('canvasDiv').appendChild(this.canvas);

    this.ctx = this.canvas.getContext("2d"); 

    this.canvas.addEventListener("touchstart", this.add_hold.bind(this), false);
    this.canvas.addEventListener("click", this.add_hold.bind(this), false);

    this.results = { 'start': [], 'top': [], 'hold': [] };

    // start with default
    this.selected_hold_type = 'hold';
    this.hold_size = 20;
  }

  add_hold(e) {
    console.log("adding hold from event e.x, e.y:" + e.x + ':' + e.y);
    console.log("left: " + this.canvas.getBoundingClientRect().left + " top: " + this.canvas.getBoundingClientRect().top);

    var x = e.x - this.canvas.getBoundingClientRect().left;
    var y = e.y - this.canvas.getBoundingClientRect().top;

    var hold = new Hold(x, y, this.selected_hold_type)
    console.log("new hold: hold.x=" + hold.x +  " hold.y=" + hold.y);

    this.actual_hold = hold;

    hold.draw(this.ctx, this.hold_size);

    this.results[hold.hold_type].push([hold.x, hold.y]);
    console.log(this.results);
  }

  change_hold_type(t)  {
    this.selected_hold_type = t;
  }
  
  bigger_hold() {
    this.actual_hold.delete;
    this.actual_hold.draw(this.ctx, this.x0, this.y0, this.hold_size * 2);
  }

  get_holds() {
    return this.results;
  }

  clear_holds() {
    this.ctx.clearRect(0, 0, this.width, this.height);
    this.results = { 'start': [], 'top': [], 'hold': [] };
  }
}

