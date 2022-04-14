<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cad_obra.aspx.cs" Inherits="cad_obra" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <script type="text/javascript" src="../Scripts/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="../Scripts/SweetAlert2/sweetalert2.all.min.js"></script>

    <title>Despesa</title>

    <script type="text/javascript">

        const swalWithBootstrapButtons = Swal.mixin({
            customClass: {
                confirmButton: 'btn btn-success',
                cancelButton: 'btn btn-danger'
            },
            buttonsStyling: false
        });

        function alertCss(mensagem) {

            texto == '';
            icon == '';
            if (mensagem == ('Gravar')) {
                var texto = ('Gravado com sucesso');
                var icon = ('success');
            }
            else if (mensagem == ('Alterar')) {
                var texto = ('Alterado com Sucesso');
                var icon = ('success');
            }
            else if (mensagem == ('Cancelar')) {
                var texto = ('Cancelado com Sucesso');
                var icon = ('success');
                /*var icon = ('error');*/
            }

            swalWithBootstrapButtons.fire({
                title: '',
                text: texto,
                icon: icon,
                confirmButtonText: 'OK',
                allowOutsideClick: false
            });
        }

        function Gravar() {


            var id_cliente = $('#hdnCliente').val();
            var nm_obra = $('#txtNomeObra').val();
            var resp = $('#txtResponsavel').val();
            var CEP = $('#txtCEP').val();
            var logradouro = $('#txtEndereco').val();
            var numero = $('#txtNumero').val();
            var complemento = '';
            var bairro = $('#txtBairro').val();
            var cidade = $('#txtCidade').val();
            var UF = $('#txtUF').val();
            var usuario = $('#hdnUsuario').val();
            var valorObra = $('#txtValorObra').val().trim().replace('.', '').replace(',', '.');

            var Cliente = {

                id: id_cliente,
                nm_cadastrou: usuario
            }

            var Endereco = {
                cep: CEP,
                logradouro: logradouro,
                numero: numero,
                complemento: complemento,
                bairro: bairro,
                cidade: cidade,
                uf: UF
            };

            var Obra = {
                nome: nm_obra,
                responsavel: resp,
                valor: valorObra,
                endereco: Endereco,
                cliente: Cliente

            };

            var obj = { 'obra': Obra };

            console.log(obj);

            $.ajax({
                type: "POST",
                url: "cad_obra.aspx/Gravar",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;

                    if (source == 'OK') {
                        alertCss('Gravar');
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
                url: "cad_obra.aspx/BuscarCEP",
                data: "{'cep':'" + cep + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;

                    $('#txtEndereco').val('');
                    $('#txtBairro').val('');
                    $('#txtCidade').val('');
                    $('#txtUF').val('');

                    if (source.logradouro == 'ERRO') {

                    } else {

                        $('#txtEndereco').val(source.logradouro);
                        $('#txtBairro').val(source.bairro);
                        $('#txtCidade').val(source.cidade);
                        $('#txtUF').val(source.uf);
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

        function BuscarCliente() {

            window.open("consultar_obra.aspx", "popup", "toolbar=no,scrollbars=no,resizable=no,lr,left=250,width=400,height=400,top=100");
        }

        function selCliente(id, nome, cnpj) {

            $.ajax({
                type: "POST",
                url: "cad_cliente.aspx/CarregarCliente",
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;

                    $('#hdnCliente').val(source.id);
                    $('#txtRazaoSocial').val(source.RazaoSocial);
                    $('#txtCEP').val(source.endereco.cep);
                    $('#txtEndereco').val(source.endereco.logradouro);
                    $('#txtNumero').val(source.endereco.numero);
                    $('#txtComplemento').val(source.endereco.complemento);
                    $('#txtBairro').val(source.endereco.bairro);
                    $('#txtCidade').val(source.endereco.cidade);
                    $('#txtUF').val(source.endereco.uf);



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

    <style type="text/css">
        /* Estilo do alert */
        .swal2-popup {
            font-size: medium !important;
        }

        .btn {
            margin: 0 0.5rem;
            font-size: medium !important;
        }
        /*Termina aqui o style do Alert*
    </style>
</head>
<body runat="server">
    <form id="form1" runat="server">
        <asp:HiddenField runat="server" ID="hdnUsuario" />
        <asp:HiddenField runat="server" ID="hdnCliente" />
        <div>
            <center>
                <table>
                    <tr>
                        <td>
                            <center>
                                <h3>Cadastrar Obra</h3>
                            </center>
                        </td>
                    </tr>
                    <tr class="trBody">
                        <td style="display: inline-flex">
                            <asp:TextBox ID="txtObra" runat="server" placeholder="Obra" CssClass="form-control" Width="500px"></asp:TextBox>
                            &nbsp;&nbsp;
                            <input type="image" src="../Css/Imagens/lupa.png" style="width: 30px; height: 30px" title="Consultar Obra" onclick="BuscarCliente();return false;" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                        </td>
                    </tr>
                    <tr class="trBody">
                        <td style="display: inline-flex">
                            <asp:TextBox ID="txtRazaoSocial" runat="server" placeholder="Cliente" CssClass="form-control" Width="500px"></asp:TextBox>
                            &nbsp;&nbsp;
                            <input type="image" src="../Css/Imagens/lupa.png" style="width: 30px; height: 30px" title="Consultar Cliente" onclick="BuscarCliente();return false;" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtNomeObra" placeholder="Nome Obra" Width="400px" CssClass="form-control" runat="server"></asp:TextBox>
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
                        <td>
                            <asp:TextBox ID="txtResponsavel" runat="server" placeholder="Responsavel" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:TextBox ID="txtValorObra" runat="server" placeholder="Valor $" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>



                    <tr>
                        <td>
                            <br />
                            <center>
                                <input type="button" id="btnGravar" value="Gravar" runat="server" class="btn btn-success" onclick="Gravar()" />
                            </center>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>
            </center>
        </div>
    </form>
</body>
</html>
