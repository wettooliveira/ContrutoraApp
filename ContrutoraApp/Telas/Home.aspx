<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Home" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="background-color: transparent">

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

            $('#body').removeClass('imagem_body');
            $('#body').addClass('body2');

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



            //document.getElementById("form2").
            //document.forms.open("cad_usuario.aspx", 'Pagina', "TOP=90%");
        }

    </script>
</head>

<body id="body" class="imagem_body">

    <div class="divMenuPrincipal" style="width: 100%; position: fixed">
        <div class="divMenuLogo">
            <img id="img" class="imgLogo" src="../Css/Imagens/proibido.png" style="width: 40px; position: center; padding-top: 8px" />
        </div>
        <div class="divMenu">
            <ul id="nav">
                <li><a href="Home.aspx">Home</a></li>
                <li><a href="#">Cadastros</a>
                    <ul>
                        <li><a href="javascript:void(0)" onclick="CarregaPaginaFrame('cad_usuario.aspx');return false;">Usuario </a></li>
                        <li><a href="javascript:void(0)" onclick="CarregaPaginaFrame('cad_cliente.aspx');return false;">Cliente/Fornecedor </a></li>
                        <li><a href="javascript:void(0)" onclick="CarregaPaginaFrame('cad_despesa.aspx');return false;">Despesa </a></li>
                        <li><a href="javascript:void(0)" onclick="CarregaPaginaFrame('cad_obra.aspx');return false;">Obras </a></li>
                         <li><a href="javascript:void(0)" onclick="CarregaPaginaFrame('cad_conta_banco.aspx');return false;">Contas </a></li>
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
                        <li><a href="javascript:void(0)" onclick="CarregaPaginaFrame('ContasPagar.aspx');return false;">Contas Pagar </a></li>
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
        <div style="background-color: #343434">
            <%--      <img runat="server" src="~/Css/Imagens/list.png" style="width: 40px; position: center; padding-top: 8px" />--%>
            <ul id="nav1">
                <li>
                    <a>
                        <img runat="server" src="~/Css/Imagens/list.png" style="width: 40px; position: center; padding-top: -10px" /></a>
                    <ul>
                        <li>
                            <img id="img2" class="imgLogo" src="../Css/Imagens/001-sair.png" style="width: 15%; display: inline; padding-top: 0" />
                            <a href="Login.aspx" style="text-align: center; display: inline; width: 90%; padding-top: 0">Sair</a>
                        </li>

                    </ul>
                </li>
            </ul>
        </div>
        <%--  <div class="divMenuFinal">
            <ul>
                <li>
                    <a  style="display:">
                        <img runat="server" src="~/Css/Imagens/list.png" style="width: 40px; position: center; padding-top: 8px" />
                    </a>
                    
                </li>
                
            </ul>            
        </div>--%>
    </div>

    <iframe id="iframe" style="width: 100%; height: 100%; padding-top: 50px" <%--style="width: 100%; height: 100vw; margin: 0; top: 0; left: 0; padding: 0;--%>></iframe>

    <footer class="footer navbar-fixed-bottom" style="height: 25px">
        <hgroup>
            <h5 style="background-color: #343434; color: white">Todos os direitos reservados LcRodrigues</h5>
        </hgroup>
    </footer>
</body>
</html>

