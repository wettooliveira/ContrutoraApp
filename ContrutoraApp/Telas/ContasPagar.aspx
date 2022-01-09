<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContasPagar.aspx.cs" Inherits="ContrutoraApp.ContasPagar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" media="screen" />
    <script type="text/javascript" src="../Scripts/jquery-3.4.1.js"></script>

    <title></title>
</head>

<script type="text/javascript" language="javascript">

    $(document).ready(function () {

        lancarDados();

    });

    function lancarDados() {

        var id_receb_new = '';

        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/TabelaContasPagar",
            data: "{'id_receb_new':'" + id_receb_new + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {
                var source = data.d;

                $('#div').html(source);
                console.log(source);


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

    function Inserir() {

        var desc_conta;
        var tipo;
        var num_parcela_string;
        var valor_string;

        desc_conta = $('#txtConta').val();
        tipo = $('#ddlTipo').val();
        num_parcela_string = $('#txtParcela').val();
        valor_string = $('#txtValor').val().trim().replace('.', '').replace(',', '.');;

        var obj = { 'desc_conta': desc_conta, 'tipo': tipo, 'num_parcela_string': num_parcela_string, 'valor_string': valor_string};

        console.log(obj);

        $.ajax({
            type: "POST",
            url: "ContasPagar.aspx/Gravar",
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "JSON",
            success: function (data) {
                var source = data.d;

                if(source == "OK")
                {
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
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>
                        <asp:TextBox ID="txtConta" runat="server" placeholder="Conta" CssClass="form-control"></asp:TextBox>
                    </td>

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

                    <td>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Gravar" OnClientClick="Inserir();return false;" />
                    </td>
                </tr>
            </table>
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
