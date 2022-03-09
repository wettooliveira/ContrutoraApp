<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cad_cliente.aspx.cs" Inherits="ContrutoraApp.cad_cliente" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" media="screen" />
    <script type="text/javascript" src="../Scripts/jquery-3.4.1.js"></script>
    <%--<link rel="stylesheet" type="text/css" href="../Css/Menu.css" media="screen" />--%>
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />



    <title></title>

    <script type="text/javascript" language="javascript">

        function Inserir() {

            var RazaoSocial = $('#txtRazaoSocial').val();
            var CNPJ = $('#txtCnpj').val();
            var IE = $('#txtInscricao').val();
            var Tel = $('#txtTel').val();
            var obs = "texte";
            var CEP = $('#txtCEP').val();
            var logradouro = $('#txtEndereco').val();
            var numero = $('#txtNumero').val();
            var complemento = $('#txtComplemento').val();
            var bairro = $('#txtBairro').val();
            var cidade = $('#txtCidade').val();
            var UF = $('#txtUF').val();

            var Endereco = {
                cep: CEP,
                logradouro: logradouro,
                numero: numero,
                complemento: complemento,
                bairro: bairro,
                cidade: cidade,
                uf: UF
            };

            var Cliente = {
                RazaoSocial: RazaoSocial,
                CNPJ: CNPJ,
                IE: IE,
                tel: Tel,
                obs: obs,
                nm_cadastrou: "SISTEMA",
                endereco: Endereco
            };

            var obj = { 'cliente': Cliente };

            $.ajax({
                type: "POST",
                url: "cad_cliente.aspx/Gravar",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {


                    if (data.d == 'OK') {
                        $('#lblAviso').html('');
                        $('#lblAviso').html('Gravado com sucesso!');
                        $('#lblAviso').css('color', 'green');

                    } else if (data.d == 'ERRO') {
                        $('#lblAviso').html('');
                        $('#lblAviso').html('Tente novamente, algo deu errado!');
                        $('#lblAviso').css('color', 'red');
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

        function BuscarCep(cep) {

            $.ajax({
                type: "POST",
                url: "cad_cliente.aspx/BuscarCEP",
                data: "{'cep':'" + cep + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;

                    $('#txtEndereco').val(source.logradouro);
                    $('#txtBairro').val(source.bairro);
                    $('#txtCidade').val(source.cidade);
                    $('#txtUF').val(source.uf);


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
</head>
<body>
    <form id="form1" runat="server">
           

        <div>    
            <center>
                <table>
                    <tr>
                        <td>
                            <center>
                                <h3>Cadastrar Cliente</h3>
                            </center>
                        </td>
                    </tr>
                    <tr class="trBody">
                        <td>
                            <asp:TextBox ID="txtRazaoSocial" runat="server" placeholder="Nome\Razão Social" CssClass="form-control" Width="500px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:TextBox ID="txtCnpj" runat="server" placeholder="CPF\CNPJ" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:TextBox ID="txtInscricao" runat="server" placeholder="RG\IE" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:TextBox ID="txtTel" runat="server" placeholder="Telefone" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtCEP" runat="server" placeholder="CEP" CssClass="form-control" Width="200px" onkeypress="return txtBoxFormat(this, '99999-999', event);" onblur="BuscarCep(this.value);" MaxLength="9"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 500px">
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtEndereco" runat="server" placeholder="Endereco" CssClass="form-control" Width="400px"></asp:TextBox>
                                    </td>
                                    <td style="width: 20px"></td>
                                    <td>
                                        <asp:TextBox ID="txtNumero" runat="server" placeholder="numero" CssClass="form-control" Width="80px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtComplemento" runat="server" placeholder="Complemento" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtBairro" runat="server" placeholder="Bairro" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 500px">
                            <table>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtCidade" runat="server" placeholder="Cidade" CssClass="form-control" Width="200px"></asp:TextBox>

                                    </td>
                                    <td style="width: 220px"></td>
                                    <td>
                                        <asp:TextBox ID="txtUF" runat="server" placeholder="UF" CssClass="form-control" Width="80px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>

                    <%--<tr>
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

                       
                    </tr>--%>


                    <tr>
                        <td style="text-align: center">
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Gravar" OnClientClick="Inserir();return false;" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center">
                            <asp:Label runat="server" ID="lblAviso"></asp:Label>
                        </td>
                    </tr>
                </table>
            </center>
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
