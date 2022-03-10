<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="menunovo.aspx.cs" Inherits="ContrutoraApp.menunovo" %>

<!DOCTYPE html>
<html>
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

    <title>HOME </title>

    <script>

        $(document).ready(function () {

        });

        //function CarregaPaginaFrame() {
        //    var ifrm = document.createElement("iframe");
        //    ifrm.setAttribute("src", "cad_usuario.aspx");
        //    ifrm.style.width = "100%";
        //    ifrm.style.height = "100%";
        //    //o iframe será criado antes da div de id = divqq
        //    var divReferencia = document.getElementById("divqq");
        //    // adiciona o novo elemento criado e seu conteúdo ao DOM
        //    document.body.insertBefore(ifrm, Divform);
        //}

        function CarregaPaginaFrame(value) {
            var frame = document.querySelector("iframe");
            frame.setAttribute("src", '' + value + '');
        }

        function abrirUsuario() {
            carregarForm();
            //document.forms[0].submit(); window.open("cad_usuario.aspx", "toolbar=no,scrollbars=no,resizable=no,left=500,width=400,height=400");
            //onclick = "window.open('cad_usuario.aspx', 'Pagina', 'STATUS=NO, TOOLBAR=NO, LOCATION=YES, DIRECTORIES=NO, RESISABLE=YES, SCROLLBARS=YES, TOP=90%, LEFT=150%, WIDTH=1000, HEIGHT=600');
        }
        function Contaspagar() {
            window.open("ContasPagar.aspx", "toolbar=no,scrollbars=no,resizable=no,lr,left=500,width=400,height=400");
        }

        function cliente() {
            window.open("cad_cliente.aspx", "toolbar=no,scrollbars=no,resizable=no,lr,left=500,width=400,height=400");
        }

        function carregarForm(value) {

            $('#Divform').val('');
            $.post(value, function (html) {
                //Essa é a função success
                //O parâmetro é o retorno da requisição 
                $('#Divform').html(html);
            });

            $('#body').removeClass('imagem_body');
            //document.getElementById("form2").
            //document.forms.open("cad_usuario.aspx", 'Pagina', "TOP=90%");
        }

    </script>

    <style>
         .divMenuFinal {
        /*    height: 60px;*/
           /* background-color: #343434;*/
           /* width: 5%;*/
         /*   color: white;*/
        }


        #nav1 {
            list-style: none inside;
            margin: 0;
            padding: 15px;
            text-align: center;
            width: 100%;
            background-color: #343434;
        }

            #nav1 li {
                display: block;
                position: relative;
                float: left;
                background-color: #343434;
                /* menu background color */
            }

                #nav1 li a {
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

                #nav1 li li a {
                    font-size: 90%;
                }

                /* smaller font size for sub menu items */

                #nav1 li:hover {
                }

                #nav1 li a:hover {
                    opacity: 0.9;
                }

            /* highlights current hovered list item and the parent list items when hovering over sub menues */

            #nav1 ul {
                position: absolute;
                padding: 0;
                left: 0;
                display: none;
                /* hides sublists */
            }

            #nav1 li:hover ul ul {
                display: none;
            }

            /* hides sub-sublists */

            #nav1 li:hover ul {
                display: block;
            }

            /* shows sublist on hover */

            #nav1 li li:hover ul {
                display: block;
                /* shows sub-sublist on hover */
                margin-left: 100px;
                /* this should be the same width as the parent list item */
                margin-top: -35px;
                /* aligns top of sub menu with top of list item */
                width: auto;
            }
    </style>

</head>

<body id="body" class="imagem_body">

    <div class="divMenuPrincipal" style="width: 100%">
        <div class="divMenuLogo">
            <img id="img" class="imgLogo" src="../Css/Imagens/proibido.png" style="width: 40px; position: center; padding-top: 8px" />
        </div>
        <div class="divMenu">
            <ul id="nav">
                <li><a href="Home.aspx">Home</a></li>
                <li><a href="#">Cadastros</a>
                    <ul>
                        <li><a href="javascript:void(0)" onclick="CarregaPaginaFrame('cad_usuario.aspx');return false;">Usuario </a></li>
                        <li><a href="javascript:void(0)" onclick="CarregaPaginaFrame('cad_cliente.aspx');return false;">Cliente </a></li>
                        <%--<li><a href="#">Financeiro »</a>
                            <ul>
                                <li><a href="javascript:void(0)" onclick="carregarForm(valeu);return false;">Contas a Pagar</a></li>
                                    <li><a href="#">Contas a Receber</a></li>
                            </ul>
                        </li>--%>
                    </ul>
                </li>
                <li><a href="#">Financeiro</a>
                    <ul>
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">Sub Item</a></li>
                        <li><a href="#">Sub Sub List »</a>
                            <ul>
                                <li><a href="#">Sub Sub Item 1</a></li>
                                <li><a href="#">Sub Sub Item 2</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><a href="#">Main Item 3</a></li>
            </ul>
        </div>
        <div id="divUsuario" class="divMenuUsuario" runat="server">
            <asp:Label ID="lblusuario" runat="server"></asp:Label>
        </div>
        <div class="" style="background-color:#343434">
            <%--      <img runat="server" src="~/Css/Imagens/list.png" style="width: 40px; position: center; padding-top: 8px" />--%>
            <ul id="nav1">
                <li>
                    <a>
                        <img runat="server" src="~/Css/Imagens/list.png" style="width: 40px; position: center;" /></a>
                    <ul>
                        <li>
                            <a href="#">Sub Item</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <br />

    <iframe id="iframePaginas" style="width: 100%; height: 100%; border: none; position: center"></iframe>

    <footer class="footer navbar-fixed-bottom" style="height: 25px">
        <hgroup>
            <h5 style="background-color: #343434; color: white">Todos os direitos reservados LcRodrigues</h5>
        </hgroup>
    </footer>
</body>
</html>
