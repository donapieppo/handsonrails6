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

    this.results = { 'start': [], 'top': [], 'point': [] };
    this.hold_type = 'point';
    this.color = 'rgba(123, 255, 255, 0.5)';
  }

  add_hold(e) {
    console.log("IN add_hold");
    console.log(e);
    console.log(e.x);
    console.log(e.y);
    console.log("color=" + this.color);

    this.context.beginPath();
    this.context.arc(e.x - this.x0, e.y - this.y0, 20, 0, 2 * Math.PI);
    this.context.closePath();
    this.context.fillStyle = this.color;
    this.context.fill();

    this.results[this.hold_type].push([e.x, e.y]);
    console.log("results=" + this.results);
    console.log(this.results);
  }

  start_hold()  {
    this.hold_type = 'start';
    this.color = 'rgba(123, 123, 123, 0.5)';
  }
  
  top_hold() {
    this.hold_type = 'top';
    this.color = 'rgba(255, 255, 123, 0.5)';
  }
  
  common_point() {
    this.hold_type = 'point';
    this.color = 'rgba(255, 123, 255, 0.5)';
  }

  get_holds() {
    return this.results;
  }

}

