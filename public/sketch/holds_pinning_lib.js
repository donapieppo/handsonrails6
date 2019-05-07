export class HoldPinner {

  constructor(width, height) {
    this.canvas = document.createElement('canvas');
    this.canvas.setAttribute('width', width);
    this.canvas.setAttribute('height', height);
    this.canvas.style.border = '2px solid blue';
    this.canvas.style.background = "url('./test.jpg')";
    this.canvas.setAttribute('id', 'canvas');
    document.getElementById('canvasDiv').appendChild(this.canvas);

    this.context = this.canvas.getContext("2d"); 

    this.x0 = this.canvas.getBoundingClientRect().left;
    this.y0 = this.canvas.getBoundingClientRect().top;

    this.canvas.addEventListener("touchstart", this.add_hold.bind(this), false);
    this.canvas.addEventListener("click", this.add_hold.bind(this), false);

    this.colors  = { 'start': 'rgba(123, 123, 123, 0.5)', 'top': 'rgba(123, 1, 123, 0.5)', 'hold': 'rgba(123, 123, 1, 0.5)' };
    this.results = { 'start': [], 'top': [], 'hold': [] };

    // start with default
    this.hold_type = 'hold';
    this.color = this.colors[this.hold_type];
  }

  add_hold(e) {
    console.log("IN add_hold");
    console.log(e);

    this.context.beginPath();
    this.context.arc(e.x - this.x0, e.y - this.y0, 20, 0, 2 * Math.PI);
    this.context.closePath();
    this.context.fillStyle = this.color;
    this.context.fill();

    this.results[this.hold_type].push([e.x, e.y]);
    console.log(this.results);
  }

  change_hold_type(t)  {
    this.hold_type = t;
    this.color = this.colors[t];
  }
  
  get_holds() {
    return this.results;
  }

}

