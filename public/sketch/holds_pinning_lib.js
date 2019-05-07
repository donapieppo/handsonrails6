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

  draw(canvas, width) {
    var context = canvas.getContext("2d"); 

    var x0 = this.x - window.scrollX;
    var y0 = this.y - window.scrollY;

    context.beginPath();
    context.lineWidth = "8";
    context.strokeStyle = this.color();
    context.arc(x0, y0, width, 0, 2 * Math.PI);
    context.closePath();
    context.stroke();

    //if (this.hold_type == 'start' || this.hold_type == 'top') {
      context.font = "16px Arial";
      context.fillText(this.hold_type, x0 + 30, y0 - 15); 
      context.fillText(this.x + ":" + this.y, x0 + 30, y0 + 15); 
    //}
  }

  delete(context, x0, y0, width) {
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

    this.context = this.canvas.getContext("2d"); 

    this.x0 = this.canvas.getBoundingClientRect().left;
    this.y0 = this.canvas.getBoundingClientRect().top;

    this.canvas.addEventListener("touchstart", this.add_hold.bind(this), false);
    this.canvas.addEventListener("click", this.add_hold.bind(this), false);

    this.results = { 'start': [], 'top': [], 'hold': [] };

    // start with default
    this.selected_hold_type = 'hold';
    this.hold_size = 20;
  }

  add_hold(e) {
    console.log("adding hold");
    console.log(this.canvas.getBoundingClientRect().top);
    // console.log(e);

    var x = e.x - this.canvas.getBoundingClientRect().left + window.scrollX;
    var y = e.y - this.canvas.getBoundingClientRect().top + window.scrollY ;

    var hold = new Hold(x, y, this.selected_hold_type)

    this.actual_hold = hold;

    hold.draw(this.canvas, this.hold_size);

    this.results[hold.hold_type].push([hold.x, hold.y]);
    console.log(this.results);
  }

  change_hold_type(t)  {
    this.selected_hold_type = t;
  }
  
  bigger_hold() {
    this.actual_hold.delete;
    this.actual_hold.draw(this.context, this.x0, this.y0, this.hold_size * 2);
  }

  get_holds() {
    return this.results;
  }

  clear_holds() {
    this.context.clearRect(0, 0, this.width, this.height);
    this.results = { 'start': [], 'top': [], 'hold': [] };
  }
}

