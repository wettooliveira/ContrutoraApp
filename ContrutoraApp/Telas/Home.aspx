<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="ContrutoraApp.Home" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" media="screen" />
    <%--<link rel="stylesheet" type="text/css" href="../Css/Menu.css" media="screen" />--%>
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

    <style type="text/css">
        .menu_div {
            background-color: rgb(37, 37, 39);
            width: 75vw;
            opacity: 0.7;
        }

        .ul {
            display: inline;
            list-style: none;
        }

            .ul div li {
                width: 150px;
                display: inline-block;
                position: relative;
            }

                .ul div li a {
                    color: #FFF;
                    opacity: 0.7;
                    text-decoration: none;
                    padding: 10px 10px;
                    display: block;
                }

                .ul li a {
                    color: #FFF;
                    opacity: 0.7;
                    text-decoration: none;
                    padding: 10px 10px;
                    display: block;
                }

                .ul li label {
                    color: #FFF;
                    opacity: 0.7;
                    text-decoration: none;
                    padding: 15px 10px;
                    display: block;
                }

                .ul div li a:hover {
                    background: #333;
                    color: #fff;
                    -moz-box-shadow: 0 3px 10px 0 #CCC;
                    -webkit-box-shadow: 0 3px 10px 0 #ccc;
                    text-shadow: 0px 0px 5px #fff;
                    opacity: 10;
                }

            .ul li a:hover {
                background: #333;
                color: #fff;
                -moz-box-shadow: 0 3px 10px 0 #CCC;
                -webkit-box-shadow: 0 3px 10px 0 #ccc;
                text-shadow: 0px 0px 5px #fff;
                opacity: 10;
            }

            .ul li ul {
                position: absolute;
                top: 40px;
                left: 0;
                background-color: transparent;
                display: none;
            }

            .ul li:hover ul, .ul li.over ul {
                display: block;
            }

            .ul li ul li {
                border: 1px solid #c0c0c0;
                display: block;
                width: 150px;
            }
    </style>

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
        <%--     <div style="display: inline-flex;">--%>

        <nav class="menu_div">

            <ul class="ul" style="display: inline-flex">
                <div>
                    <li><a href="https://satellasoft.com">Home </a></li>

                    <li><a href="https://satellasoft.com">Sobre </a></li>

                    <li>
                        <a href="https://satellasoft.com">o que </a>
                        <ul>
                            <li><a style="padding: 5px; background-color: rgb(37, 37, 39);" href="https://satellasoft.com">foi </a></li>

                            <li><a style="padding: 5px; background-color: rgb(37, 37, 39);" href="https://satellasoft.com">Quem Somos</a></li>
                        </ul>
                    </li>
                </div>


                <li style="justify-self: right;">
                    <asp:ImageButton runat="server" ImageUrl="~/Imagens/icons8-cardápio-24.png" Width="25px" Style="position: center" />
                    <ul>
                        <li><a style="padding: 5px; background-color: rgb(37, 37, 39);" href="https://satellasoft.com">foi </a></li>

                        <li><a style="padding: 5px; background-color: rgb(37, 37, 39);" href="https://satellasoft.com">Quem Somos</a></li>
                    </ul>
                </li>
            </ul>


        </nav>

        <%--       </div>--%>



        </div>

            <%--<div>
                 <nav class="menu_div">
                    <ul class="ul">
                        <li><a href="https://satellasoft.com">Home </a></li>

                        <li><a href="https://satellasoft.com">Sobre </a></li>

                        <li>
                            <a href="https://satellasoft.com">o que </a>
                            <ul>
                                <li>
                                    <a style="padding: 5px; background-color: rgb(37, 37, 39);" href="https://satellasoft.com">foi </a>
                                </li>
                            </ul>
                        </li>--%>

        <%-- <li style="width: 500px"></li>--%>

        <%-- <li ><a href="https://academy.satellasoft.com">Sobre</a></li>

                <li><a href="#">Quem Somos</a></li>

                <li><a href="#">Contato</a></li>

                <li><a href="#">Entrar</a></li>--%>
        <%--          </ul>
                </nav>
            </div>--%>



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

