<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cad_conta_banco.aspx.cs" Inherits="cad_conta_banco" %>

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

        $(document).ready(function () {

            $("#btnExcluir").attr("style", "visibility: hidden");

        });

        function nome(id_usuario, desc_conta, desc_despesa) {

            $('#hdnBanco').val(id_usuario);
            $('#txtAgencia').val(desc_conta.split('-')[0].trim());
            $('#txtConta').val(desc_conta.split('-')[1].trim());
            $('#ddlBanco option[value=' + id_usuario + ']').attr('selected', 'selected');
            $('#btnGravar').val('Alterar');
            $("#btnExcluir").attr("style", "visibility: ");

        }

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
            else if (mensagem == ('Excluir')) {
                var texto = ('Excluido com Sucesso');
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

            var cod_banco = $('#ddlBanco').val();
            var agencia = $('#txtAgencia').val();
            var conta = $('#txtConta').val();
            var tipo = $('#btnGravar').val();


            var contaBanco = {
                cod_banco: cod_banco,
                ds_agencia: agencia,
                ds_conta: conta,
                tipo: tipo

            };

            var obj = { 'conta': contaBanco };

            console.log(obj);

            $.ajax({
                type: "POST",
                url: "cad_conta_banco.aspx/Gravar",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;

                    if (source == 'gravou') {
                        alertCss('Gravar');
                    } else {
                        alertCss('Alterar');
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

        function BuscarObra() {

            window.open("consultar_obra.aspx", "popup", "toolbar=no,scrollbars=no,resizable=no,lr,left=250,width=400,height=400,top=100");
        }

        function selObra(id, nome, cnpj) {

            $.ajax({
                type: "POST",
                url: "cad_obra.aspx/CarregarObra",
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;


                    $('#hdnCliente').val(source.cliente.id);
                    $('#hdnObra').val(source.id);
                    $('#txtRazaoSocial').val(source.cliente.RazaoSocial);
                    $('#txtNomeObra').val(source.nome);
                    $('#txtCEP').val(source.endereco.cep);
                    $('#txtEndereco').val(source.endereco.logradouro);
                    $('#txtNumero').val(source.endereco.numero);
                    $('#txtComplemento').val(source.endereco.complemento);
                    $('#txtBairro').val(source.endereco.bairro);
                    $('#txtCidade').val(source.endereco.cidade);
                    $('#txtUF').val(source.endereco.uf);
                    $('#txtResponsavel').val(source.responsavel);
                    $('#txtValorObra').val(source.valor_string);
                    $('#txtObra').val(source.id);

                    $('#btnGravar').val('Alterar');

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

            window.open("consultar_cliente.aspx", "popup", "toolbar=no,scrollbars=no,resizable=no,lr,left=250,width=400,height=400,top=100");
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

        function excluir() {



            swalWithBootstrapButtons.fire({
                title: 'Deseja excluir conta?',
                text: '',
                icon: 'warning',
                confirmButtonText: 'Sim',
                cancelButtonText: 'Não',
                showCancelButton: true,
                reverseButtons: false,
                allowOutsideClick: false
            }).then((result) => {
                if (result.value) {

                    var id = $('#hdnBanco').val();


                    $.ajax({
                        type: "POST",
                        url: "cad_conta_banco.aspx/ExcluirConta",
                        data: "{'id':'" + id + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "JSON",
                        success: function (data) {
                            var source = data.d;

                            alertCss('Excluir');

                            $('#hdnBanco').val('');
                            $('#txtAgencia').val('');
                            $('#txtConta').val('');
                            $('#ddlBanco option[value=' + 0 + ']').attr('selected', 'selected');
                            $('#btnGravar').val('Gravar');
                            $("#btnExcluir").attr("style", "visibility: hidden ");

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

                } else {                   
                    //swalWithBootstrapButtons.fire(
                    //    'Contrato gerado com sucesso',
                    //    'Numero do contrato: ' + $('#hdnNumero_Contrato').val(),
                    //    'success'
                    //)

                } 

           

            })
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
        /*Termina aqui o style do Alert*/

        .Grid td {
            padding: 2px;
            border: solid 1px #c1c1c1;
        }

        .Grid th {
            padding: 4px 2px;
            color: #fff;
            background: #4682B4;
            border-left: solid 1px #525252;
            font-size: 0.9em;
        }

        .Grid .alt {
            background: #F8F8FF;
        }

        .Grid .pgr {
            background: #363670;
        }

            .Grid .pgr table {
                margin: 3px 0;
            }

            .Grid .pgr td {
                border-width: 0;
                padding: 0 6px;
                border-left: solid 1px #666;
                font-weight: bold;
                color: #fff;
                line-height: 12px;
            }

            .Grid .pgr a {
                color: Gray;
                text-decoration: none;
            }

                .Grid .pgr a:hover {
                    color: #000;
                    text-decoration: none;
                }
    </style>
</head>
<body runat="server">
    <form id="form1" runat="server">
        <asp:HiddenField runat="server" ID="hdnUsuario" />
        <asp:HiddenField runat="server" ID="hdnBanco" />
        <asp:HiddenField runat="server" ID="hdnObra" />
        <div>
            <center>
                <table>
                    <tr>
                        <td>
                            <center>
                                <h3>Cadastrar Conta</h3>
                            </center>
                        </td>
                    </tr>
                    <%--      <tr class="trBody">
                        <td style="display: inline-flex">
                            <asp:TextBox ID="txtObra" runat="server" placeholder="Obra" CssClass="form-control" Width="500px"></asp:TextBox>
                            &nbsp;&nbsp;
                            <input type="image" src="../Css/Imagens/lupa.png" style="width: 30px; height: 30px" title="Consultar Obra" onclick="BuscarObra();return false;" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                        </td>
                    </tr>--%>
                    <%--     <tr class="trBody">
                        <td style="display: inline-flex">
                            <asp:TextBox ID="txtRazaoSocial" runat="server" placeholder="Cliente" CssClass="form-control" Width="500px"></asp:TextBox>
                            &nbsp;&nbsp;
                            <input type="image" src="../Css/Imagens/lupa.png" style="width: 30px; height: 30px" title="Consultar Cliente" onclick="BuscarCliente();return false;" />
                        </td>
                    </tr>--%>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlBanco" placeholder="Nome Obra" Width="400px" CssClass="form-control" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtAgencia" placeholder="Agencia" Width="400px" CssClass="form-control" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtConta" runat="server" placeholder="Conta" CssClass="form-control" Width="200px"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <br />
                            <center>
                                <input type="button" id="btnGravar" value="Gravar" runat="server" class="btn btn-success" onclick="Gravar()" />
                            </center>
                        </td>

                        <td>
                            <br />
                            <center>
                                <input type="button" id="btnExcluir" value="Excluir" visible="true" runat="server" class="btn btn-danger" onclick="excluir()" />
                            </center>
                        </td>

                        <td>
                            <br />
                            <center>
                                <asp:Button ID="btnFiltrar" Text="Buscar" CssClass="btn btn-primary" runat="server" OnClick="btnFiltrar_Click" />
                            </center>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <br />
                        </td>
                    </tr>

                    <tr>
                        <td align="" colspan="2">
                            <asp:GridView ID="GridUsuario" CssClass="Grid" runat="server" AutoGenerateColumns="false" Width="600px"
                                AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt" PagerStyle-CssClass="pgr" HeaderStyle-HorizontalAlign="Center" OnPageIndexChanging="GridUsuario_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            Conta
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <span style="cursor: pointer;" onclick="nome( '<%# DataBinder.Eval(Container.DataItem, "id")%> ','<%# DataBinder.Eval(Container.DataItem, "desc_conta")%> ','<%# DataBinder.Eval(Container.DataItem, "desc_despesa")%> ')" />
                                            <%# DataBinder.Eval(Container.DataItem, "desc_conta")%>
                                       </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Bottom" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="" DataField="desc_despesa" HeaderText="Banco" />
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>

                </table>
            </center>
        </div>
    </form>
</body>
</html>
