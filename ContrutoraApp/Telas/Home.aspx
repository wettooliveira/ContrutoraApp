<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Home" %>


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

    <title> HOME </title>

    <script>

        $(document).ready(function () {
         
        });


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
            
            $.post(value, function (html) {
                //Essa é a função success
                //O parâmetro é o retorno da requisição 
                $('#form2').html(html);
            });

            $('#body').removeClass();
            //document.getElementById("form2").
            //document.forms.open("cad_usuario.aspx", 'Pagina', "TOP=90%");
        }

    </script>

     
</head>

<body id="body" class="imagem_body">
   
    <div class="divMenuPrincipal">
        <div class="divMenuLogo">     
            <img id="img" src="../Css/Imagens/proibido.png"  style="width:40px; position:center; padding-top:8px" />
        </div>
        <div class="divMenu">
            <ul id="nav">
                <li><a href="#">Home</a></li>
                <li><a href="#">Cadastros</a>
                    <ul>
                        <li><a href="javascript:void(0)" onclick="carregarForm('cad_usuario.aspx');return false;"> Usuario </a></li>
                        <li><a href="javascript:void(0)" onclick="carregarForm('cad_cliente.aspx');return false;" > Cliente </a></li>
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
        <div id="divUsuario" class="divMenuUsuario" runat="server"> </div>
        <div class="divMenuFinal">
            <img runat="server" src="~/Css/Imagens/list.png" style="width: 40px; position: center; padding-top: 8px" />
        </div>
    </div>
    <br />

    <form id="form2" runat="server">
    </form>  

    <footer class="footer navbar-fixed-bottom" style="height:25px">
       <hgroup>
            <h5 style="background-color: #343434;color:white">Todos os direitos reservados LcRodrigues</h5>
        </hgroup>
    </footer>
</body>
</html>

