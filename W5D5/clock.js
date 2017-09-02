class Clock {
  constructor() {

    // 1. Create a Date object.
    this.date = new Date();
    // 2. Store the hours, minutes, and seconds.
    this.hours = this.date.getHours();
    this.minutes = this.date.getMinutes();
    this.seconds = this.date.getSeconds();
    // 3. Call printTime.
    this.printTime();
    // 4. Schedule the tick at 1 second intervals.
    this._tick();

    setInterval(this._tick.bind(this), 1000);
  }

  printTime() {
    // Format the time in HH:MM:SS
    // Use console.log to print it.
    console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
  }

  _tick() {
    // 1. Increment the time by one second.
    const addSecond = function addSecond () {
      this.date = new Date();
      this.hours = this.date.getHours();
      this.minutes = this.date.getMinutes();
      this.seconds = this.date.getSeconds();
      this.printTime();
    };

    // 2. Call printTime.
    setTimeout(addSecond.bind(this), 1000);
  }
}

const clock = new Clock();
