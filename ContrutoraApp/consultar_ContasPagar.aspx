<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="consultar_ContasPagar.aspx.cs" Inherits="ContrutoraApp.consultar_ContasPagar" %>

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
    <script type="text/javascript" src="../Scripts/SweetAlert2/sweetalert2.all.min.js"></script>
    <title>Consultar Contas a Pagar</title>


</head>
<body>

    <script language="javascript" type="text/javascript">
        {
            window.resizeTo(800, 600);
        }
        $(document).ready(function () {

            TabelaLancarDados();

            /*  Menu();*/

        });

        function TabelaLancarDados() {

            $('#btnPagas').val("Pagas");
            var status = "";
            $.ajax({
                type: "POST",
                url: "consultar_ContasPagar.aspx/TabelaContasPagar",
                data: "{'status':'" + status + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;

                    $('#div').html(source);
                    $('#btnPagas').prop("disabled", false);

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


    <form id="form1" runat="server">

        <div>
            <table>
                <tr>
                    <td>
                         <asp:TextBox runat="server" Width="100px" placeHolder="Numero Conta" CssClass="form-control"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button runat="server" ID="btnGravar" CssClass="btn btn-info" Text="Buscar" OnClientClick="TabelaLancarDados();return false;" />
                    </td>
                </tr>
            </table>           
        </div>
        <div style="width: 100%">
            <br />
            <center>
                <table style="width: 90%">
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
