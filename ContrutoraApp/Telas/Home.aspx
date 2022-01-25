<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ContrutoraApp.Home" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" media="screen" />
    <script type="text/javascript" src="../Scripts/jquery-3.4.1.js"></script>
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

        $(document).ready(function () {
                       
            Menu();

        });

        function Menu() {


            $.ajax({
                type: "POST",
                url: "Home.aspx/Menu",
                data: "{'m':'m'}",
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;
                    $('#menu').html(source);



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

  <style type="text/css">
     /*   .menu_div {
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
            }*/
    </style>
</head>



<body class="teste">

      <form id="form2" runat="server">
        <asp:HiddenField ID="HiddenField1" runat="server" />

          <div id="menu">
        </div>
               
        
        <table style="width: 100%">
            <tr>
                <td>
                    <br />
                    <br />
                </td>
                <td style="text-align: center">
                    <asp:Label runat="server" ID="Label1" Font-Size="Medium" Text="Seja bem vindo:"></asp:Label>&nbsp;<asp:Label ID="Label2" Font-Size="Medium" runat="server"></asp:Label>       
                </td>
            </tr>
        </table>

        <div style="width:80%">

        </div>
    </form>

</body>



</html>

