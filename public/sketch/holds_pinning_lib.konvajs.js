const colors = { 
  'start': 'rgba(123, 123, 123, 0.9)', 
  'top':   'rgba(123, 1, 123, 0.9)', 
  'hold':  'rgba(123, 123, 1, 0.9)' 
};

export class HoldLabel {
  constructor(x, y, label_type) {
    this.x = x;
    this.y = y;
    this.label_type = label_type;

    const common = { x: this.x, y: this.y, strokeWidth: 8, stroke: 'blue', draggable: true };

    this.label = new Konva.Label({
      x: this.x - 120,
      y: this.y - 15,
      opacity: 0.75, 
      draggable: true,
    });

    this.label.add(
      new Konva.Text({
        text: this.label_type,
        fontFamily: 'Calibri',
        fontSize: 38,
        padding: 5,
        fill: 'black',
        align: 'right'
      })
    );
    this.label.add(
      new Konva.Tag({
        fill: 'yellow',
        cornerRadius: 5
      })
    );

    this.label.on('dragend', () => {
      this.x = this.label.attrs.x;
      this.y = this.label.attrs.y;
    });
  }

  // to delete having pin from konvajs and anyway only one hold in a x:y
  hold_label_key() {
    return (`${this.label.attrs.x}:${this.label.attrs.y}`);
  }
}

export class Hold {

  constructor(x, y, hold_type) {
    this.x = x;
    this.y = y;
    this.hold_type = hold_type;

    const common = { x: this.x, y: this.y, strokeWidth: 8, stroke: this.color(), draggable: true }

    if (hold_type == 'start') {
      this.pin = new Konva.Star({
        ...common, ... { numPoints: 6, innerRadius: 30, outerRadius: 50 }
      });
    } else if (hold_type == 'hold') {
      this.pin = new Konva.Circle({
        ...common, ... { radius: 30 }
      });
    } else if (hold_type == 'top') {
      this.pin = new Konva.Star({
        ...common, ... { numPoints: 6, innerRadius: 30, outerRadius: 50 }
      });
    } 

    this.pin.on('dragend', () => {
      this.x = this.pin.attrs.x;
      this.y = this.pin.attrs.y;
    });
  }

  color() {
    return colors[this.hold_type];
  }

  // to delete having pin from konvajs and anyway only one hold in a x:y
  hold_key() {
    return (`${this.pin.attrs.x}:${this.pin.attrs.y}`);
  }
}

export class HoldPinner {

  constructor(width, height) {
    this.width = width;
    this.height = height;
    this.selected_hold_type = 'start';

    this.holds = {};

    this.valid = false;
    this.dragging = false;
    
    this.stage = new Konva.Stage({
       container: 'canvasDiv', 
       width:  this.width,
       height: this.height
    });

    this.layer = new Konva.Layer();
    this.stage.add(this.layer);

    this.stage.on('click', (e) => {
      this.add_hold(e);
    });
  }

  add_hold(e) {
    console.log(e);
    console.log("adding hold from event e.x, e.y:" + e.evt.layerX + ':' + e.evt.layerY);

    const x = e.evt.layerX 
    const y = e.evt.layerY

    const hold = new Hold(x, y, this.selected_hold_type)
    console.log(`new hold: hold.x=${hold.x} hold.y=${hold.y} hold.type=${hold.hold_type}`);

    this.actual_hold = hold;

    this.layer.add(hold.pin).draw();
    if (hold.hold_type != 'hold') {
      const hold_label = new HoldLabel(x, y, this.selected_hold_type)
      this.layer.add(hold_label.label).draw();
    }

    this.holds[hold.hold_key()] = hold;
    console.log(this.holds);
  }

  change_hold_type(th)  {
    this.selected_hold_type = th;
  }
  
  get_holds() {
    console.log(this.holds);
    return Object.keys(this.holds).map((h_k) => { 
      return { x: this.holds[h_k].x, 
               y: this.holds[h_k].y, 
               hold_type: this.holds[h_k].hold_type }
    });
  }
}

