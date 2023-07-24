unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    // declare essa lib no uses acima "Vcl.ExtCtrls"
    //crie uma variavel global para receber o captcha
     Captcha:string;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2;

//criar uma função para gerar o captcha
function CriaCaptcha(Imagem: TImage; Num_Chars: Integer): String;
var
  //criar variaveis locais do tipo string
  Chars, Captcha: String;
  //criar variaveis locais do tipo int
  I, X, Y, Tamanho, Espaco, Cor: Integer;
begin
  //utilizaremos a função nativa do delphi para randomizar os valores em texto, numeros, tamanhos, espaços e cores
  Randomize;
  Chars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
    'abcdefghijklmnopqrstuvwxyz1234567890';

  Y := 6;
  X := 10;
  Tamanho := 20;
  Espaco := 40;
  Cor := 5999857;

  //preparando o TImage para receber os valores randomizados
  with (Imagem) do
  begin
    Refresh;
    Canvas.LineTo(10, 20);
    Picture.Bitmap := nil;
    Canvas.Brush.Color := $00F7F8F9;
    Canvas.Pen.Color := $00F7F8F9;
    Canvas.Rectangle(0, 0, Width, Height);
  end;

  //selecionando os caracteres randomizados
  Captcha := '';
  for I := 0 to Num_Chars do
  begin
    Captcha := Captcha + Copy(Chars, Random(Length(Chars)), 1);
  end;

  //desenhando os caracteres na image
  for I := 1 to Length(Captcha) - 1 do
  begin
    with (Imagem) do
    begin
      Canvas.Font.Size := Random(Tamanho) + 15;
      Canvas.Font.Color := Random(Cor);
      Canvas.Font.Name := 'Times New Roman';
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
      Canvas.TextOut(X, Random(Y), Copy(Captcha, I, 1));
    end;

    Inc(X, Espaco);

    //criando rabiscos para embaralhar
    with (Imagem) do
    begin
      Canvas.Pen.Width := 3;
      Canvas.Pen.Color := Random(Cor);
      Canvas.LineTo(Random(250), Random(200));
      Canvas.LineTo(Random(250), Random(200));
    end;
  end;

  //lendo o valor retornado do codigo para validação
  Result := Copy(Captcha, 1, Length(Captcha) - 1);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //alimentando a variavel globla com o captcha gerado
  Captcha := CriaCaptcha(Image1, 4);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  //verificando se o valor digitado na edit é igual a do gerado na imagem, gravado na variavel global
  //obs. é totalmente keysensitive
  if (Edit1.Text = Captcha) then
    ShowMessage('Código válido!')
  else
    ShowMessage('Código inválido!');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
form2.show;
end;

end.
