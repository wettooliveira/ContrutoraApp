<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="ContrutoraApp.Home" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/Menu.css" media="screen" />
    <script type="text/javascript" src="../Scripts/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="../Scripts/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Scripts/bootstrap.js"></script>


    <title><%: Page.Title %> - HOME </title>

    <script>
        function abrirUsuario() {
            window.open("cad_usuario.aspx", "toolbar=no,scrollbars=no,resizable=no,left=500,width=400,height=400");

        }
        function Contaspagar() {
            window.open("ContasPagar.aspx", "toolbar=no,scrollbars=no,resizable=no,lr,left=500,width=400,height=400");

        }

        function cliente() {
            window.open("cad_cliente.aspx", "toolbar=no,scrollbars=no,resizable=no,lr,left=500,width=400,height=400");

        }


        function Menu() {
            var menu = "";          
           menu =" <ul id='nav'>";
           menu += "<li><a href='#'>HOME</a></li>";
           menu += "<li><a href='#'>CADASTROS</a>";
           menu += "<ul>";
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">SUB SUB LIST »</a>
                            <ul>
                                <li><a href="#">Sub Sub Item 1</a>
                                    <li><a href="#">Sub Sub Item 2</a>
                            </ul>
                                </li>
                            </ul>
                        </li>
                        <li><a href="#">FINANCEIRO</a>
                            <ul>
                                <li><a href="#">Sub Item</a></li>
                                <li><a href="#">Sub Item</a></li>
                                <li><a href="#">SUB SUB LIST »</a>
                                    <ul>
                                        <li><a href="#">Sub Sub Item 1</a>
                                            <li><a href="#">Sub Sub Item 2</a>
                            </ul>
                                        </li>
                                    </ul>
                                </li>
                                <li><a href="#">Main Item 3</a></li>
                            </ul>
                            ";
                        
        }

    </script>

 
    <%--/*Menu Anterior ou Site--%>
    <%--  <div class="navbar navbar-inverse navbar-fixed-top">
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
            </div>--%>
</head>

<body class="imagem_body">

    <div class="divMenuPrincipal">
        <div class="divMenuLogo">
            <img runat="server" src="~/Imagens/proibido.png" style="width: 40px; position: center; padding-top: 8px" />
        </div>
        <div class="divMenu">
            <ul id="nav">

                <li><a href="#">HOME</a></li>
                <li><a href="#">CADASTROS</a>
                    <ul>
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">SUB SUB LIST »</a>
                            <ul>
                                <li><a href="#">Sub Sub Item 1</a>
                                    <li><a href="#">Sub Sub Item 2</a>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><a href="#">FINANCEIRO</a>
                    <ul>
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">SUB SUB LIST »</a>
                            <ul>
                                <li><a href="#">Sub Sub Item 1</a>
                                    <li><a href="#">Sub Sub Item 2</a>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><a href="#">Main Item 3</a></li>
            </ul>
        </div>

        <div class="divMenuFinal">
            <img runat="server" src="~/Imagens/list.png" style="width: 40px; position: center; padding-top: 8px" />
        </div>

    </div>
    <br />

    <form id="form2" runat="server">

        <table style="width: 100%">
            <tr>
                <td>
                    <br />
                    <br />
                </td>
                <td style="text-align: center">
                    <asp:Label runat="server" ID="Label1" Font-Size="Medium" Text="Seja bem vindo:"></asp:Label>
                    &nbsp;<asp:Label ID="Label2" Font-Size="Medium" runat="server"></asp:Label>
                </td>
            </tr>
        </table>

        <div style="width: 80%">
        </div>

    </form>

    <%--<webopt:BundleReference runat="server" Path="~/Content/css" />--%>
</body>


</html>

