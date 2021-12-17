<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="ContrutoraApp.Home" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/Menu.css" media="screen" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>
    <webopt:BundleReference runat="server" Path="~/Content/css" />

    <title><%: Page.Title %> - Meu Aplicativo ASP.NET</title>

    <script>
        function abrirUsuario() {
            window.open("cad_usuario.aspx", "toolbar=no,scrollbars=no,resizable=no,left=500,width=400,height=400");

        }
        function abrirCadUsuario() {
            window.open("cad_cliente_venda.aspx", "toolbar=no,scrollbars=no,resizable=no,lr,left=500,width=400,height=400");

        }


    </script>
</head>
<body class="teste" style="width: 100%">

    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnUNomeUsuario" runat="server" />

        <%--        <div class="navbar navbar-inverse navbar-fixed-top">
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
                        <li><a href="home">Página inicial</a></li>

                        <li><a style="cursor: pointer" onclick="abrirUsuario()">Usuario</a></li>
                        <li><a style="cursor: pointer" onclick="abrirCadUsuario()">Cadastro Atendimento</a></li>
                        <li><a href="About">Sobre</a></li>
                        <li><a href="Contact">Contato</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="Account/Register">Registrar</a></li>
                        <li><a href="Login">Logon</a></li>
                    </ul>
                </div>
                <div>
                    <ul class="nav navbar-nav">

                           <li><a href="Login">item</a></li>
                    </ul>

                </div>
            </div>

        </div>--%>


        <nav class="menu_div">
            <ul class="ul">
                <li>
                    <a href="https://satellasoft.com">Home </a>
                </li>

                <li>
                    <a href="https://satellasoft.com">Sobre </a>
                </li>

                <li>

                    <a href="https://satellasoft.com">o que </a>

                    <ul >
                        <li>
                            <a href="https://satellasoft.com">foi </a>
                        </li>
                    </ul>

                </li>

                <%-- <li ><a href="https://academy.satellasoft.com">Sobre</a></li>

                <li><a href="#">Quem Somos</a></li>

                <li><a href="#">Contato</a></li>

                <li><a href="#">Entrar</a></li>--%>
            </ul>
        </nav>

        <br />

        <div>
            <table style="width: 100%">
                <tr>
                    <td>
                        <br />
                        <br />
                    </td>
                    <td style="text-align: center">
                        <asp:Label runat="server" ID="lblNome" Font-Size="Medium" Text="Seja bem vindo:"></asp:Label>&nbsp;<asp:Label ID="lblNmUsuario" Font-Size="Medium" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </form>

</body>
</html>

