<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="ContrutoraApp.Home" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" media="screen" />
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

    </script>

    <%--  <style type="text/css">
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
    </style>--%>

    <style>
        #nav {
            list-style: none inside;
            margin: 0;
            padding: 15px;
            text-align: center;
            width: 100%;
            background-color: #343434;
        }

            #nav li {
                display: block;
                position: relative;
                float: left;
                background-color: #343434;
                /* menu background color */
            }

                #nav li a {
                    display: block;
                    padding: 0;
                    text-decoration: none;
                    width: 100px;
                    /* this is the width of the menu items */
                    line-height: 35px;
                    /* this is the hieght of the menu items */
                    color: #ffffff;
                    opacity: 0.6;
                    /* list item font color */
                }

                #nav li li a {
                    font-size: 90%;
                }

                /* smaller font size for sub menu items */

                #nav li:hover {
                }

                #nav li a:hover {
                    opacity: 0.9;
                }

            /* highlights current hovered list item and the parent list items when hovering over sub menues */

            #nav ul {
                position: absolute;
                padding: 0;
                left: 0;
                display: none;
                /* hides sublists */
            }

            #nav li:hover ul ul {
                display: none;
            }

            /* hides sub-sublists */

            #nav li:hover ul {
                display: block;
            }

            /* shows sublist on hover */

            #nav li li:hover ul {
                display: block;
                /* shows sub-sublist on hover */
                margin-left: 100px;
                /* this should be the same width as the parent list item */
                margin-top: -35px;
                /* aligns top of sub menu with top of list item */
            }
    </style>

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

    <div style="height: 60px; display: inline-flex; width: 100%;">
        <div style="height: 60px; background-color: #343434; width: 10%; color: white">
            <img runat="server" src="~/Imagens/proibido.png" style="width: 40px; position: center; padding-top: 8px" />
        </div>
        <div style="height: 60px; background-color: #343434; width: 85%">
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

        <div style="height: 60px; background-color: #343434; width: 5%; color: white; align-items: center">
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

