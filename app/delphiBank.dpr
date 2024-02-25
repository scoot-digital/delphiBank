program delphiBank;

{$APPTYPE CONSOLE}

{$R *.res}


//  Import required units
uses
  System.SysUtils,
  Tests in 'Tests.pas';


{
  Close the program
}
procedure QuitApplication();

  begin

    Writeln('Thank you for using delphiBank');
    Writeln('Please press enter to close the program...');

    Readln;

    Halt;

  end;


{
  Start a new interaction with the user, asking what they would like to do
  @param UserInput (string) - represents what the user would like to do
}
procedure NewInteraction();

  var
  UserInput : string;
  UserDecision : string;

  begin

    //  Ask the user what they would like to do
    Writeln('What would you like to do?');
    Writeln('(1 - Create an account, 2 - Make a deposit, 3 - Make a withdrawal, 4 - Generate a statement, Q - Quit application)');
    Readln(UserInput);

    //  Set the user's input to lower case
    UserDecision := LowerCase(UserInput);

    //  Quit the application
    if UserDecision = 'q' then
      QuitApplication()
    //  If anything else was entered, ask the user to try again
    else
      Writeln('Response invalid');
      NewInteraction();
  end;

//  Main program loop
begin

  try

    //  Greet the user
    GreetUser();

    //  Begin program main loop
    NewInteraction();

  except

    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);

  end;

end.