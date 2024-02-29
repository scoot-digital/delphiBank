unit TestBank;

interface

  uses
    DUnitX.TestFramework, Bank;

  type
    [TestFixture]
    TMyTestObject = class

    private



    public

      [Setup]
      procedure Setup;
      [TearDown]
      procedure TearDown;



    end;


implementation

procedure TMyTestObject.Setup;

  begin



  end;

procedure TMyTestObject.TearDown;

  begin



  end;

initialization

  TDUnitX.RegisterTestFixture(TMyTestObject);

end.
