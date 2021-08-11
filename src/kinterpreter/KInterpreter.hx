package kinterpreter;

import rm.core.TouchInput;
import rm.core.Input;

using core.MathExt;

typedef Step = {
  fn:Void -> Void,
  ?wait:Int,
  ?playerInput:Bool
}

@:native('KInterpreter')
@:expose('KInterpreter')
class KInterpreter {
  public var currentCommand:Step;
  public var commands:Array<Step>;
  public var waitTime:Int;
  public var playerInput:Bool;
  puclic var isAnimationRunning: Bool;
  public var animationTime: Int;

  public function new(commands:Array<Step>) {
    this.commands = commands;
    // Modify commands if necessary
    for (command in this.commands) {
      if (command.wait == null) {
        command.wait = Main.Params.waitTime;
      }
      if (command.playerInput == null) {
        command.playerInput = false;
      }
      if (command.isAnimation == null) {
        command.isAnimation = false;
      }
    }
    this.isAnimationRunning = false;
    this.animationTime = 0;
    this.waitTime = 0;
    this.playerInput = false;
  }

  /**
   * Adds a command to the list of commands available for processing.
   * @param command 
   */
  public function addCommand(command:Step) {
    if (command.wait == null) {
      command.wait = Main.Params.waitTime;
    }
    if (command.playerInput == null) {
      command.playerInput = false;
    }
    if (command.isAnimation == null) {
      command.isAnimation = false;
    }
    this.commands.push(command);
    return this;
  }

  public function removeCommand(index:Int) {
    this.commands.splice(index, 1);
    return this;
  }

  public function update() {
    var playerCommands = (Input.isTriggered('ok')
      || Input.isTriggered('cancel') || TouchInput.isPressed());
    if (this.waitTime <= 0 && !this.playerInput) {
      this.advanceCommand();
    }
    if (this.isAnimationRunning) {
      return
    }
    // Automatically advance when given player input
    if (this.playerInput && playerCommands) {
      this.advanceCommand();
    }

    // Decrement Wait time
    this.waitTime = (this.waitTime - 1).clamp(0, 9000000);
  }

  public function advanceCommand() {
    this.currentCommand = this.commands.shift();
    if (this.currentCommand != null) {
      if (this.currentCommand.isAnimation) {
        this.isAnimationRunning = true
        this.ticker.start()
        this.ticker.add((time) => {
          if (this.animationTime <= 0) {
            this.ticker.stop()
            this.isAnimationRunning = false
          }
          this.currentCommand.fn()
          this.animationTime--
        })
      } else {
        this.currentCommand.fn()
      }
      this.waitTime = this.currentCommand.wait;
      this.playerInput = this.currentCommand.playerInput;
      this.isAnimation = this.currentCommand.isAnimation;
      this.animationTime = this.currentCommand.animationTime;
    }
  }
}