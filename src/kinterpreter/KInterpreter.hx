package kinterpreter;

import rm.core.TouchInput;
import rm.core.Input;

typedef Step = {
  fn:Void -> Void,
  wait:Int,
  playerInput:Bool
}

@:native('KInterpreter')
@:expose('KInterpreter')
class KInterpreter {
  public var currentCommand:Step;
  public var commands:Array<Step>;
  public var waitTime:Int;
  public var playerInput:Bool;

  public function new(commands:Array<Step>) {
    this.commands = commands;
    this.waitTime = 0;
    this.playerInput = false;
  }

  /**
   * Adds a command to the list of commands available for processing.
   * @param command 
   */
  public function addCommand(command:Step) {
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

    // Automatically advance when given player input
    if (this.playerInput && playerCommands) {
      this.advanceCommand();
    }
  }

  public function advanceCommand() {
    this.currentCommand = this.commands.shift();
    if (this.currentCommand != null) {
      this.currentCommand.fn();
      this.waitTime = this.currentCommand.wait;
      this.playerInput = this.currentCommand.playerInput;
    }
  }
}