unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  Datasnap.DBClient, Datasnap.Win.MConnect, Datasnap.Win.SConnect,
  System.Win.ScktComp, Web.Win.Sockets,json, Vcl.ExtCtrls,IdCoderMIME,DATA.DBXJSONCOMMON,
  IdBaseComponent, IdCoder, IdCoder3to4, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxImage,Vcl.Imaging.pngimage,System.NetEncoding,
  IdComponent, IdTCPConnection, IdTCPClient,idglobal, dxGDIPlusClasses,json.writers;

type
  TForm1 = class(TForm)
    ClientSocket1: TClientSocket;
    Memo1: TMemo;
    Button6: TButton;
    ServerSocket1: TServerSocket;
    Memo2: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Image1: TImage;
    IdDecoderMIME1: TIdDecoderMIME;
    IdTCPClient1: TIdTCPClient;
    Button17: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Memo3: TMemo;
    Memo4: TMemo;
    Button16: TButton;
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Connecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Restart(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);

    procedure GetdeviceInfo(json:string);
    procedure GetDeviceSetting(json:string);
    procedure GetUserIdList(json:string);
    procedure GetUserInfo(json:string);
    procedure GetLogData(json:string);
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure Button16Click(Sender: TObject);



  private
    function StreamToString(aStream: TStream): string;
    procedure jsonparse(json:string);
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}








procedure TForm1.Restart(Sender: TObject);
VAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"Restart"}';
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));



//  Header[0] := byte(length(a));
//  Header[1] := byte(length(a) shr 8);
//  Header[2] := byte(length(a) shr 16);
//  Header[3] := byte(length(a) shr 24  );  //
//
//
//  Header[4] := Byte(PROTOCOLKEY)   ;
//  Header[5] := byte(PROTOCOLKEY shr 8);
//  Header[6] := byte(PROTOCOLKEY shr 16);
//  Header[7] := byte(PROTOCOLKEY shr 24  );
//
//  Header[8] := Byte(socKetPwd)   ;
//  Header[9] := byte(socKetPwd shr 8);
//  Header[10] := byte(socKetPwd shr 16);
//  Header[11] := byte(socKetPwd shr 24  );



Mesaj_BytesSize:=length(Mesaj_Bytes);
move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
move(socKetPwd,header[8],sizeof(socKetPwd));

// for i := 0 to 31 do
//begin
//  NewSendBuff[i]:=Header[i];
//end;
move(header[0],newsendbuff[0],headerlen);

//for i := 0 to High(Mesaj_Bytes) do
//  BEGIN
//   NewSendBuff[i+HEADERLEN]:=Mesaj_Bytes[i] ;
//  END;

move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;




  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;

end;



procedure TForm1.Button10Click(Sender: TObject);
VAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;



 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);
      // {"cmd":"GetUserInfo","data":{"packageId":0,"usersId":["1"]}}
 Mesaj:='{"cmd":"GetUserInfo","data":{"packageId":0,"usersId":["1"]}}';  //kullanıcı listesi aldığımız userİd Gönderiyoruz
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);



// SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));
 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes)+length(TEncoding.UTF8.GetBytes(#1)));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));

  move( TEncoding.UTF8.GetBytes(#1)[0],newsendbuff[HEADERLEN+length(Mesaj_Bytes)],length(TEncoding.UTF8.GetBytes(#1))) ;


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;




  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;



end;

procedure TForm1.Button11Click(Sender: TObject);
VAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
  ClientSocket1.Open;
  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"GetDeviceInfo"}  ';
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;


end;

procedure TForm1.Button12Click(Sender: TObject);
vAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:tbytes;//array of byte;
 a:Tbytes;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"GetLogData","data":{"packageId":0,"newLog":0,"beginTime":"20211001","endTime":"20211102","clearMark":0}}';
// okuduktan sonra silinmesi isteniyorsa "clearMark":1 olarak gönderilir.
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


// SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));
 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes)+length(TEncoding.UTF8.GetBytes(#1)));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));



  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));

//memo3.Lines.Text:=TEncoding.UTF8.GetString(newsendbuff,low(newsendbuff),high(newsendbuff)+1)   ;
 move( TEncoding.UTF8.GetBytes(#1)[0],newsendbuff[HEADERLEN+length(Mesaj_Bytes)],length(TEncoding.UTF8.GetBytes(#1))) ;
 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;


end;

procedure TForm1.Button13Click(Sender: TObject);
vAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"ClearLogData"}';
 // okuduktan sonra silinmesi isteniyorsa "clearMark":1 olarak gönderilir.
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;



end;

procedure TForm1.Button14Click(Sender: TObject);
vAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;


  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"EnterEnroll","data":{"userId":"1","feature":"fp"}}';
 // userId 1 olan personele parmaz izi eklemek
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;



end;

procedure TForm1.Button15Click(Sender: TObject);
vAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;


  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"EnterEnroll","data":{"userId":"1","feature":"face"}}';
 // userId 1 olan personele yüz eklemek
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;


end;



procedure TForm1.Button16Click(Sender: TObject);
var

 json, data : TJsonObject;
    users : TJsonArray;
    jsp : TJsonPair;


 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;



 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;
begin
  try

    json := TJsonObject.Create();
    data:=TJSONObject.Create();

    users := TJsonArray.Create();

    jsp := TJSONPair.Create('cmd', 'SetUserInfo');
    json.AddPair(jsp);

    json.AddPair(TJSONPair.Create('data',data));


    users := TJsonArray.Create();

    jsp := TJSONPair.Create('users', users);
    data.AddPair(jsp);
       //ilk önce Getuserinfo ilek kayıtların olup olmadığını kontrol et
      //kaydı olmayanların kaydını döngü ile tüm elemanları ekle
    data := TJsonObject.Create();

    data.AddPair(TJsonPair.Create('userId', '1'));
    data.AddPair(TJsonPair.Create('name', 'Doğan akçay'));
    data.AddPair(TJsonPair.Create('privilege',TJSONNumber.Create(0)));
    data.AddPair(TJsonPair.Create('card', '9770272'));
    data.AddPair(TJsonPair.Create('pwd', '1904'));
    data.AddPair(TJsonPair.Create('fps', '[]'));  //parmak izi array olarak ekle
    data.AddPair(TJsonPair.Create('face', TJSONNull.Create ));
    data.AddPair(TJsonPair.Create('palm', TJSONNull.Create));
    data.AddPair(TJsonPair.Create('photo', TJSONNull.Create));  //fotoğraf var ise string olarak ekle   base64
    data.AddPair(TJsonPair.Create('vaildStart', TJSONNull.Create));
    data.AddPair(TJsonPair.Create('vaildEnd', TJSONNull.Create));
    data.AddPair(TJsonPair.Create('update', TJSONNumber.Create(0)));
    data.AddPair(TJsonPair.Create('photoEnroll', TJSONNumber.Create(0)));


    users.AddElement(data);

    //ikinci eleman kısıtlı verisi
    data := TJsonObject.Create();

    data.AddPair(TJsonPair.Create('userId', '1'));
    data.AddPair(TJsonPair.Create('name', 'Doğan akçay'));
    data.AddPair(TJsonPair.Create('privilege',TJSONNumber.Create(0)));
    data.AddPair(TJsonPair.Create('card', '1234'));
    data.AddPair(TJsonPair.Create('pwd', '1904'));
    data.AddPair(TJsonPair.Create('fps', '[]'));  //parmak izi array olarak ekle
    data.AddPair(TJsonPair.Create('face', TJSONNull.Create ));
    data.AddPair(TJsonPair.Create('palm', TJSONNull.Create));
    data.AddPair(TJsonPair.Create('photo', TJSONNull.Create));  //fotoğraf var ise string olarak ekle   base64
    data.AddPair(TJsonPair.Create('vaildStart', TJSONNull.Create));
    data.AddPair(TJsonPair.Create('vaildEnd', TJSONNull.Create));
    data.AddPair(TJsonPair.Create('update', TJSONNumber.Create(0)));
    data.AddPair(TJsonPair.Create('photoEnroll', TJSONNumber.Create(0)));

    users.AddElement(data);

   // memo3.Lines.Text:=json.ToString;
     ////////////gönderim
             if ClientSocket1.Socket.Connected=false then
              ClientSocket1.Open;

              sleep(100);
              socKetPwd:=0;
              PROTOCOLKEY:=404232216;//$18181818;

              SetLength(Header,32);
                  // {"cmd":"GetUserInfo","data":{"packageId":0,"usersId":["1"]}}
             Mesaj:=json.ToString;
             showmessage(inttostr(length(mesaj)));
             Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);



               SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));
//             SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes)+length(TEncoding.UTF8.GetBytes(#1)));


              Mesaj_BytesSize:=length(Mesaj_Bytes);
              move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
              move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
              move(socKetPwd,header[8],sizeof(socKetPwd));


              move(header[0],newsendbuff[0],headerlen);
              move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));

//              move( TEncoding.UTF8.GetBytes(#1)[0],newsendbuff[HEADERLEN+length(Mesaj_Bytes)],length(TEncoding.UTF8.GetBytes(#1))) ;


             ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;




              for I := 0 to length(NewSendBuff)-1 do
                begin
                    if i<32 then
                    BEGIN
                    memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
                    END ELSE BEGIN
                    memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
                    END;
                end;





  finally
   if Assigned(json) then   json.Free;
  end;


end;

procedure TForm1.Button1Click(Sender: TObject);
VAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"GetDeviceInfo"}';
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;

end;

procedure TForm1.Button2Click(Sender: TObject);
VAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"ResetDevice"}';
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;


end;

procedure TForm1.Button3Click(Sender: TObject);
VAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"SetDoorStatus","data":{"doorStatus":"open"}}';
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;

end;

procedure TForm1.Button4Click(Sender: TObject);
VAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"SetDoorStatus","data":{"doorStatus":"open_close"}}';
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;


end;

procedure TForm1.Button5Click(Sender: TObject);
VAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"SetDoorStatus","data":{"doorStatus":"close"}}';
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;


end;

procedure TForm1.Button7Click(Sender: TObject);
VAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"SetTime","data":{"syncTime":"20211026102522"}}';   //    20211026101622    format yyyymmddhh24miss
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;

end;

procedure TForm1.Button8Click(Sender: TObject);
VAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin
if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"GetDeviceSetting"}';
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;


end;

procedure TForm1.Button9Click(Sender: TObject);
VAR
 Mesaj:string;
 Mesaj_Bytes:TBytes;
 socKetPwd:int32;//integer;   //通讯密码
 PROTOCOLKEY:integer;  //协议token

 Header: array of byte;
 NewSendBuff:array of byte;
 i,Mesaj_BytesSize: Integer;

 const
 len:integer=4;
 HEADERLEN:INTEGER=32;
 ReceiveBufferSize:integer=409600;

begin

if ClientSocket1.Socket.Connected=false then
  ClientSocket1.Open;

  sleep(100);
  socKetPwd:=0;
  PROTOCOLKEY:=404232216;//$18181818;

  SetLength(Header,32);

 Mesaj:='{"cmd":"GetUserIdList","data":{"packageId":0}}';
 Mesaj_Bytes:=TEncoding.UTF8.GetBytes(Mesaj);


 SetLength(NewSendBuff,HEADERLEN+length(Mesaj_Bytes));


  Mesaj_BytesSize:=length(Mesaj_Bytes);
  move(Mesaj_BytesSize,header[0],sizeof(length(Mesaj_Bytes)));
  move(PROTOCOLKEY,header[4],sizeof(PROTOCOLKEY));
  move(socKetPwd,header[8],sizeof(socKetPwd));


  move(header[0],newsendbuff[0],headerlen);
  move(Mesaj_Bytes[0],newsendbuff[32],length(Mesaj_Bytes));


 ClientSocket1.Socket.SendBuf(NewSendBuff[0],length(newsendbuff)) ;

  for I := 0 to length(NewSendBuff)-1 do
    begin
        if i<32 then
        BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+INTTOSTR(NewSendBuff[i]);
        END ELSE BEGIN
        memo1.Lines.Text:=memo1.Lines.Text+TEncoding.UTF8.GetString(NewSendBuff[i]);
        END;
    end;



end;

procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
form1.Caption:='Bağlantı Sağlandı';
end;

procedure TForm1.ClientSocket1Connecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
form1.Caption:='bağlatı sağlanıyor';
end;

procedure TForm1.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
form1.Caption:='Bağlatı kesildi';
end;

procedure TForm1.ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
showmessage('hata oluştu');
end;

procedure tform1.jsonparse(json:string);
var
jsonobject:TJSONObject;
data:TJSONObject;
resultdata:TJSONObject;
usersarray:TJSONArray;
users:TJSONObject;
  i: Integer;
  S:STRING;
BEGIN

JSONObject  :=TJSONObject.Create;
resultdata:=TJSONObject.Create;


data:=TJSONObject.Create;
try
jsonobject.Parse(BytesOf(JSON),0)      ;

if (jsonobject.GetValue('cmd').ToString='"GetUserInfo"') and (jsonobject.GetValue('result_code').ToString='0') then
begin
//resultdata.Parse(bytesof(jsonobject.Values['Result_Data'].ToString),0) ;
// data.Parse(BytesOf(jsonobject.Values['data'].ToString),0);
// showmessage(data.GetValue('packageId').ToString);

//usersarray:=resultdata.GetValue('users') as TJSONArray;

//for i := 0 to usersarray.Count-1 do
//begin
//  users:=TJSONObject.Create;
//  try
////    users.Parse(bytesof(usersarray.Items[i].ToString),0);
////    showmessage('cart no'+users.GetValue('card').ToString);
//
//  finally
//   users.Free;
//  end;
//
//
//end;

end;



finally
 jsonobject.Free;
 resultdata.Free;

end;

end;
procedure TForm1.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
 var
  Size,i: Integer;
  Bytes: TBytes;
  hata:integer;

  //// json değişkenleri
  jsonobject:TJSONObject;
  data:TJSONObject;
  resultdata:TJSONObject;
  usersarray:TJSONArray;
  users:TJSONObject;
//  i: Integer;
  json:STRING;
begin

  Size := Socket.ReceiveLength;
  SetLength(Bytes, Size);
  Socket.ReceiveBuf(Bytes[0], socket.ReceiveLength);

//ServerSocket1.Socket.SendBuf(Bytes[0], socket.ReceiveLength);
//ServerSocket1.Socket.Connections[0].SendBuf(Bytes[0], socket.ReceiveLength);
 try
 json:=TEncoding.UTF8.GetString(bytes)  ;
 except
   exit;
 end;


  memo2.Text:=json;

 /// json oluşturma
JSONObject  :=TJSONObject.Create;
resultdata:=TJSONObject.Create;



try

jsonobject.Parse(BytesOf(JSON),0)      ;

    if jsonobject.GetValue('result_code').ToString='0' then
    begin
        //'{"cmd":"Restart"}';
        if (jsonobject.GetValue('cmd').ToString='"Restart"')  then
        begin
        showmessage('restar');
        end;
        //'{"cmd":"GetDeviceInfo"}';
        if (jsonobject.GetValue('cmd').ToString='"GetDeviceInfo"')  then
        begin
        GetdeviceInfo(json);
        end;
        //'{"cmd":"ResetDevice"}';
        if (jsonobject.GetValue('cmd').ToString='"ResetDevice"')  then
        begin
        showmessage('"ResetDevice"');
        end;
        //'{"cmd":"SetDoorStatus","data":{"doorStatus":"open"}}';
        if (jsonobject.GetValue('cmd').ToString='"SetDoorStatus"')  then
        begin
        showmessage('"SetDoorStatus"');
        end;
        //'{"cmd":"SetDoorStatus","data":{"doorStatus":"open_close"}}';
        if (jsonobject.GetValue('cmd').ToString='"SetDoorStatus"')  then
        begin
        showmessage('"SetDoorStatus"');
        end;
       //'{"cmd":"SetDoorStatus","data":{"doorStatus":"close"}}';
        if (jsonobject.GetValue('cmd').ToString='"SetDoorStatus"')  then
        begin
        showmessage('"SetDoorStatus"');
        end;
        //'{"cmd":"SetTime","data":{"syncTime":"20211026102522"}}';
        if (jsonobject.GetValue('cmd').ToString='"SetTime"')  then
        begin
        showmessage('"SetTime"');
        end;
        //'{"cmd":"GetDeviceSetting"}';
        if (jsonobject.GetValue('cmd').ToString='"GetDeviceSetting"')  then
        begin
        GetDeviceSetting(json);
        end;
        //'{"cmd":"GetUserIdList","data":{"packageId":0}}';
        if (jsonobject.GetValue('cmd').ToString='"GetUserIdList"')  then
        begin
        GetUserIdList(json);
        end;
        //'{"cmd":"GetUserInfo","data":{"packageId":0,"usersId":["1"]}}';
        if (jsonobject.GetValue('cmd').ToString='"GetUserInfo"')  then
        begin
        GetUserInfo(json);

        end;
        //{"cmd":"GetLogData","data":{"packageId":0,"newLog":0,"beginTime":"20211001","endTime":"20211031","clearMark":0}}
         if (jsonobject.GetValue('cmd').ToString='"GetLogData"')  then
        begin
        GetLogData(json);

        end;


    end;



finally
 jsonobject.Free;
 resultdata.Free;

end;






end;






procedure TForm1.GetdeviceInfo(json: string);
var
//// json değişkenleri
  jsonobject:TJSONObject;
  data:TJSONObject;
  resultdata:TJSONObject;
  usersarray:TJSONArray;
  users:TJSONObject;
begin
Memo2.Text:='';
JSONObject  :=TJSONObject.Create;
resultdata:=TJSONObject.Create;

 try

      try
      jsonobject.Parse(BytesOf(JSON),0)      ;

              if (jsonobject.GetValue('cmd').ToString='"GetDeviceInfo"')  then
              begin
              resultdata.Parse(bytesof(jsonobject.Values['result_data'].ToString),0) ;
              Memo2.Lines.Add('AlllogCount'+ '= '+resultdata.GetValue('allLogCount').ToString);
              Memo2.Lines.Add('cardCount'+ '= '+resultdata.GetValue('cardCount').ToString);
              Memo2.Lines.Add('cardLimit'+ '= '+resultdata.GetValue('cardLimit').ToString);
              Memo2.Lines.Add('deviceId'+ '= '+resultdata.GetValue('deviceId').ToString);
              Memo2.Lines.Add('faceCount'+ '= '+resultdata.GetValue('faceCount').ToString);
              Memo2.Lines.Add('faceLimit'+ '= '+resultdata.GetValue('faceLimit').ToString);
              Memo2.Lines.Add('faceVer'+ '= '+resultdata.GetValue('faceVer').ToString);
              Memo2.Lines.Add('firmware'+ '= '+resultdata.GetValue('firmware').ToString);
              Memo2.Lines.Add('fpCount'+ '= '+resultdata.GetValue('fpCount').ToString);
              Memo2.Lines.Add('fpLimit'+ '= '+resultdata.GetValue('fpLimit').ToString);
              Memo2.Lines.Add('fpVer'+ '= '+resultdata.GetValue('fpVer').ToString);
              Memo2.Lines.Add('logCount'+ '= '+resultdata.GetValue('logCount').ToString);
              Memo2.Lines.Add('logLimit'+ '= '+resultdata.GetValue('logLimit').ToString);
              Memo2.Lines.Add('managerCount'+ '= '+resultdata.GetValue('managerCount').ToString);
              Memo2.Lines.Add('maxBufferLen'+ '= '+resultdata.GetValue('maxBufferLen').ToString);
              Memo2.Lines.Add('name'+ '= '+resultdata.GetValue('name').ToString);
              Memo2.Lines.Add('pwdCount'+ '= '+resultdata.GetValue('pwdCount').ToString);
              Memo2.Lines.Add('pwdLimit'+ '= '+resultdata.GetValue('pwdLimit').ToString);
              Memo2.Lines.Add('userCount'+ '= '+resultdata.GetValue('userCount').ToString);
              Memo2.Lines.Add('userLimit'+ '= '+resultdata.GetValue('userLimit').ToString);

              end;



      finally
       jsonobject.Free;
       resultdata.Free;

      end;
 except
 on E: EConvertError do ShowMessage(E.ClassName + LF + E.Message);
 end;

end;

procedure TForm1.GetDeviceSetting(json: string);
var
//// json değişkenleri
  jsonobject:TJSONObject;
  data:TJSONObject;
  resultdata:TJSONObject;
  usersarray:TJSONArray;
  users:TJSONObject;
  brightLed:TJSONObject;
begin
Memo2.Text:='';
JSONObject  :=TJSONObject.Create;
resultdata:=TJSONObject.Create;
brightLed:=TJSONObject.Create;



try
jsonobject.Parse(BytesOf(JSON),0)      ;

        if (jsonobject.GetValue('cmd').ToString='"GetDeviceSetting"')  then
        begin
        resultdata.Parse(bytesof(jsonobject.Values['result_data'].ToString),0) ;
        Memo2.Lines.Add('alarmDelay'+ '= '+resultdata.GetValue('alarmDelay').ToString);
        Memo2.Lines.Add('antiPass'+ '= '+resultdata.GetValue('antiPass').ToString);
        brightLed.Parse(BytesOf(resultdata.Values['brightLed'].ToString),0   ) ;
        Memo2.Lines.Add('brightLed'+#13+'  mode'+ '= '+brightLed.GetValue('mode').ToString);
      //  Memo2.Lines.Add('brightLed'+ '= '+resultdata.GetValue('brightLed').ToString);
        Memo2.Lines.Add('devName'+ '= '+resultdata.GetValue('devName').ToString);
        Memo2.Lines.Add('interval'+ '= '+resultdata.GetValue('interval').ToString);
        Memo2.Lines.Add('language'+ '= '+resultdata.GetValue('language').ToString);
        Memo2.Lines.Add('living'+ '= '+resultdata.GetValue('living').ToString);
        Memo2.Lines.Add('openDoorDelay'+ '= '+resultdata.GetValue('openDoorDelay').ToString);
        Memo2.Lines.Add('pushEnable'+ '= '+resultdata.GetValue('pushEnable').ToString);
        Memo2.Lines.Add('pushServerHost'+ '= '+resultdata.GetValue('pushServerHost').ToString);
        Memo2.Lines.Add('pushServerPort'+ '= '+resultdata.GetValue('pushServerPort').ToString);
        Memo2.Lines.Add('reverifyTime'+ '= '+resultdata.GetValue('reverifyTime').ToString);
        Memo2.Lines.Add('screensaversTime'+ '= '+resultdata.GetValue('screensaversTime').ToString);
        Memo2.Lines.Add('serverHost'+ '= '+resultdata.GetValue('serverHost').ToString);
        Memo2.Lines.Add('serverPort'+ '= '+resultdata.GetValue('serverPort').ToString);
        Memo2.Lines.Add('sleepTime'+ '= '+resultdata.GetValue('sleepTime').ToString);
        Memo2.Lines.Add('tamperAlarm'+ '= '+resultdata.GetValue('tamperAlarm').ToString);
        Memo2.Lines.Add('verifyMode'+ '= '+resultdata.GetValue('verifyMode').ToString);
        Memo2.Lines.Add('volume'+ '= '+resultdata.GetValue('volume').ToString);
        Memo2.Lines.Add('wiegandType'+ '= '+resultdata.GetValue('wiegandType').ToString);

        end;



finally
 jsonobject.Free;
 resultdata.Free;
 brightLed.Free;

end;
end;

procedure TForm1.GetLogData(json: string);
var
i:integer;
//// json değişkenleri
  jsonobject:TJSONObject;
  data:TJSONObject;
  resultdata:TJSONObject;
  LOGS:TJSONArray;
  log:TJSONObject;

  Juser:TJSONObject;
  brightLed:TJSONObject;
begin
Memo2.Text:='';
JSONObject  :=TJSONObject.Create;
resultdata:=TJSONObject.Create;
LOGS:=TJSONArray.Create;



try
jsonobject.Parse(BytesOf(JSON),0)      ;

        if (jsonobject.GetValue('cmd').ToString='"GetLogData"')  then
        begin
        resultdata.Parse(bytesof(jsonobject.Values['result_data'].ToString),0) ;

        Memo2.Lines.Add('packageId'+ '= '+resultdata.GetValue('packageId').ToString);
        Memo2.Lines.Add('allLogCount'+ '= '+resultdata.GetValue('allLogCount').ToString);
        Memo2.Lines.Add('logsCount'+ '= '+resultdata.GetValue('logsCount').ToString);

        LOGS:=TJSONObject.ParseJSONValue(resultdata.GetValue('logs').Value) as TJSONArray;


 for I := 0 to logs.Count-1 do
            begin

            try

                  log:=TJSONObject.Create;
                  log.Parse(BytesOf((logs.Items[i] as TObject).ToString),0);

                   if log.FindValue('doorMode')<>nil then
                  Memo2.Lines.Add('doorMode'+ '= '+log.GetValue('doorMode').ToString);
                   if log.FindValue('inOut')<>nil then
                  Memo2.Lines.Add('inOut'+ '= '+log.GetValue('inOut').ToString);
                   if log.FindValue('ioMode')<>nil then
                  Memo2.Lines.Add('ioMode'+ '= '+log.GetValue('ioMode').ToString);
                   if log.FindValue('inOut')<>nil then
                  //logphoto
                   if log.FindValue('time')<>nil then
                  Memo2.Lines.Add('time'+ '= '+log.GetValue('time').ToString);
                   if log.FindValue('userId')<>nil then
                  Memo2.Lines.Add('userId'+ '= '+log.GetValue('userId').ToString);
                   if log.FindValue('verifyMode')<>nil then
                  Memo2.Lines.Add('verifyMode'+ '= '+log.GetValue('verifyMode').ToString);

                finally
                  log.Free;
                end;
            end;




        end;




finally
 jsonobject.Free;
 resultdata.Free;
 logs.Free;

end;
end;

procedure TForm1.GetUserIdList(json: string);
var
i:integer;
//// json değişkenleri
  jsonobject:TJSONObject;
  data:TJSONObject;
  resultdata:TJSONObject;
  usersarray:TJSONArray;
  users:TJSONObject;

  Juser:TJSONObject;
  brightLed:TJSONObject;
begin
Memo2.Text:='';
JSONObject  :=TJSONObject.Create;
resultdata:=TJSONObject.Create;
usersarray:=TJSONArray.Create;



try
jsonobject.Parse(BytesOf(JSON),0)      ;

        if (jsonobject.GetValue('cmd').ToString='"GetUserIdList"')  then
        begin
        resultdata.Parse(bytesof(jsonobject.Values['result_data'].ToString),0) ;

        Memo2.Lines.Add('packageId'+ '= '+resultdata.GetValue('packageId').ToString);
        Memo2.Lines.Add('usersCount'+ '= '+resultdata.GetValue('usersCount').ToString);
        usersarray:=TJSONObject.ParseJSONValue(resultdata.GetValue('users').ToString) as TJSONArray;

            for I := 0 to usersarray.Count-1 do
            begin
            try
              Juser:=TJSONObject.Create;
              Juser.Parse(BytesOf((usersarray.Items[i] as TObject).ToString),0);

              Memo2.Lines.Add('name'+ '= '+Juser.GetValue('name').ToString);
              Memo2.Lines.Add('userId'+ '= '+Juser.GetValue('userId').ToString);

            finally
              Juser.Free;
            end;
            end;


        end;




finally
 jsonobject.Free;
 resultdata.Free;
 usersarray.Free;

end;
end;

procedure TForm1.GetUserInfo(json: string);
var
i:integer;
//// json değişkenleri
  jsonobject:TJSONObject;
  data:TJSONObject;
  resultdata:TJSONObject;
  usersarray:TJSONArray;
  users:TJSONObject;

  Juser:TJSONObject;


// s : TMemoryStream;
// png : timage;
// bb : TBytes;
// a:TJSONArray;
// strmm:TStream;
// image:TImage;

  sm:TMemoryStream;
  s: string;


begin
Memo2.Text:='';
JSONObject  :=TJSONObject.Create;
resultdata:=TJSONObject.Create;
usersarray:=TJSONArray.Create;



try
jsonobject.Parse(BytesOf(JSON),0)      ;

        if (jsonobject.GetValue('cmd').ToString='"GetUserInfo"')  then
        begin
        resultdata.Parse(bytesof(jsonobject.Values['result_data'].ToString),0) ;

        Memo2.Lines.Add('packageId'+ '= '+resultdata.GetValue('packageId').ToString);
        Memo2.Lines.Add('usersCount'+ '= '+resultdata.GetValue('usersCount').ToString);

        usersarray:=TJSONObject.ParseJSONValue(resultdata.GetValue('users').ToString) as TJSONArray;

            for I := 0 to usersarray.Count-1 do
            begin

            try
              Juser:=TJSONObject.Create;
              Juser.Parse(BytesOf((usersarray.Items[i] as TObject).ToString),0);

              if Juser.FindValue('card')<>nil then
              Memo2.Lines.Add('card'+ '= '+Juser.GetValue('card').ToString);
              if Juser.FindValue('name')<>nil then
              Memo2.Lines.Add('name'+ '= '+Juser.GetValue('name').ToString);
              if Juser.FindValue('privilege')<>nil then
              Memo2.Lines.Add('privilege'+ '= '+Juser.GetValue('privilege').ToString);
              if Juser.FindValue('pwd')<>nil then
              Memo2.Lines.Add('pwd'+ '= '+Juser.GetValue('pwd').ToString);
              if Juser.FindValue('userId')<>nil then
              Memo2.Lines.Add('userId'+ '= '+Juser.GetValue('userId').ToString);
              if Juser.FindValue('vaildEnd')<>nil then
              Memo2.Lines.Add('vaildEnd'+ '= '+Juser.GetValue('vaildEnd').ToString);
              if Juser.FindValue('vaildStart')<>nil then
              Memo2.Lines.Add('vaildStart'+ '= '+Juser.GetValue('vaildStart').ToString);



              if Juser.FindValue('photo')<>nil then
              begin
              s:=Juser.GetValue('photo').Value;

                sm:=TMemoryStream.Create;
                try
                  sm.Position:=0;
//                 for I :=0 to  memo4.Lines.Count-1 do  // jsondan aldığımızda direk değeri kullanıyoruz text satır sonlarını kullanmıyoruz
//                  begin
//                  s:=s+Memo4.Lines[i];
//                  end;
                  IdDecoderMIME1.DecodeStream( s, sm );
                  sm.Position:=0;
                  Image1.Picture.Graphic.LoadFromStream(sm);
                finally
                  sm.Free;
                end;
              end;



//            strm:=TMemoryStream.Create;
//            try
//             IdDecoderMIME1.DecodeStream(s,strm);
//             Strm.Position:=0;
//             Image1.Picture.LoadFromStream(strm);
//            finally
//              strm.Free;
//            end;



            finally
              Juser.Free;
            end;
            end;


        end;





finally
 jsonobject.Free;
 resultdata.Free;
 usersarray.Free;

end;
end;

procedure TForm1.IdTCPClient1Connected(Sender: TObject);
begin
label1.Caption:='Bağlanıldı';
end;

procedure TForm1.IdTCPClient1Disconnected(Sender: TObject);
begin
label1.Caption:='Bağlantı Kesildi';
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
  var
  Size,i: Integer;
  Bytes: TBytes;
begin
  Size := Socket.ReceiveLength;
  SetLength(Bytes, Size);
  Socket.ReceiveBuf(Bytes[0], socket.ReceiveLength);




  for I := 0 to length(bytes) do
  begin
   if I<32 then
   BEGIN
   MEMO1.Lines.Text:=Memo1.Lines.Text+INTTOSTR(BYTES[I]);
   END ELSE
   BEGIN

  Memo1.Lines.Text:=Memo1.Lines.Text+(TEncoding.UTF8.GetString(bytes[i]))   ;
   END;

  end;

// Memo1.Text:=Memo1.Text+TEncoding.UTF8.GetString(Socket.ReceiveBuf,SOCKET.ReceiveLength);
      if ClientSocket1.Socket.Connected= false then
      begin
      ClientSocket1.Open;
      end;
       ClientSocket1.Socket.SendBuf(bytes[0],length(bytes));

end;

function Tform1.StreamToString(aStream: TStream): string;
var
  SS: TStringStream;
begin
  if aStream <> nil then
  begin
    SS := TStringStream.Create('');
    try
      SS.CopyFrom(aStream, 0);  // No need to position at 0 nor provide size
      Result := SS.DataString;
    finally
      SS.Free;
    end;
  end else
  begin
    Result := '';
  end;
end;


end.
