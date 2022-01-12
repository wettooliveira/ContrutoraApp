<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cad_cliente.aspx.cs" Inherits="ContrutoraApp.cad_cliente" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" media="screen" />
    <%--<link rel="stylesheet" type="text/css" href="../Css/Menu.css" media="screen" />--%>
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title></title>

    <script type="text/javascript" language="javascript">-

            function Inserir() {

                var  = $('#txtConta').val();
                var desc_conta = $('#txtConta').val();
                var tipo = $('#ddlTipo').val();
                var num_parcela_string = $('#txtParcela').val();
                var valor_string = $('#txtValor').val().trim().replace('.', '').replace(',', '.');

                var Contas = {
                    desc_conta: desc_conta,
                    tipo: tipo,
                    num_parcela_string: num_parcela_string,
                    valor_string: valor_string
                };

                var obj = { 'Contas': Contas };

                console.log(obj);

                $.ajax({
                    type: "POST",
                    url: "ContasPagar.aspx/Gravar",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "JSON",
                    success: function (data) {
                        var source = data.d;

                        if (source == "OK") {
                            lancarDados();
                        }


                    },
                    error: function (request, status, error) {
                        alert(request.responseText);
                        console.log(request.responseText);
                        //swalWithBootstrapButtons.fire({
                        //    title: '',
                        //    text: 'Erro ao abrir tabela! Tente novamente!',
                        //    icon: 'error',
                        //    confirmButtonText: 'OK',
                        //    allowOutsideClick: false
                        //}).then((result) => {
                        /*  });*/
                    }
                });

            }

    </script>
</head>
<body>
    <form id="form1" runat="server">

        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <img src="imagem/logo.lampada.png.png" width="30px" height="50px" />
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="Home.aspx">Página inicial</a></li>

                        <li><a style="cursor: pointer" onclick="abrirUsuario()">Usuario</a></li>
                        <li><a style="cursor: pointer" onclick="Contaspagar()">Financeiro</a></li>
                        <li><a style="cursor: pointer" onclick="cliente()">Cadastros</a></li>
                        <li><a href="cad_cliente.aspx" style="cursor: pointer">Cadastros</a></li>
                        <li><a href="About">Sobre</a></li>
                        <li><a href="Contact">Contato</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="Account/Register">Registrar</a></li>
                        <li><a href="Login">Logon</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <br />
        <br />



        <div>
            <br />
            <center>
                <table>
                    <tr class="trBody">
                        <td>
                            <asp:TextBox ID="txtRazaoSocial" runat="server" placeholder="Nome\Razão Social" CssClass="form-control" Width="400px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:TextBox ID="txtCnpj" runat="server" placeholder="CPF\CNPJ" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:TextBox ID="txtInscricao" runat="server" placeholder="RG\IE" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:TextBox ID="txtTel" runat="server" placeholder="Telefone" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtEndereco" runat="server" placeholder="Endereco" CssClass="form-control" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtBairro" runat="server" placeholder="Bairro" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 400px">
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtCidade" runat="server" placeholder="Cidade" CssClass="form-control" Width="200px"></asp:TextBox>

                                    </td>
                                    <td style="width: 110px"></td>
                                    <td>
                                        <asp:TextBox ID="txtUF" runat="server" placeholder="UF" CssClass="form-control" Width="90px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                    </tr>

                    <%--<tr>
                        <td>
                            <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Selecione" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Dinheiro" Value="dinheiro"></asp:ListItem>
                                <asp:ListItem Text="Débito" Value="debito"></asp:ListItem>
                                <asp:ListItem Text="Crédito" Value="credito"></asp:ListItem>
                                <asp:ListItem Text="Cheque" Value="cheque"></asp:ListItem>
                            </asp:DropDownList>
                        </td>

                        <td>
                            <asp:TextBox ID="txtParcela" runat="server" placeholder="Parcela" CssClass="form-control"></asp:TextBox>
                        </td>

                        <td>
                            <asp:TextBox ID="txtValor" runat="server" placeholder="Valor" CssClass="form-control"></asp:TextBox>
                        </td>

                       
                    </tr>--%>


                    <tr>
                        <td style="text-align: center">
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Gravar" OnClientClick="Inserir();return false;" />
                        </td>
                    </tr>
                </table>
            </center>
        </div>
        <div style="width: 100%">
            <br />
            <br />
            <center>
                <table style="width: 70%">
                    <tr>
                        <td>
                            <div id="div"></div>
                        </td>
                    </tr>
                </table>
            </center>
        </div>
    </form>
</body>
</html>
