namespace TrabalhoAPI.Models.ViewModels
{
    public class ViewModelListaCompras
    {
        public long IdCompra { get; set; }
        public long IdFornecedor { get; set; }
        public string NomeFornecedor { get; set; }
        public long IdProduto { get; set; }
        public string DescricaoProduto { get; set; }
        public string DataCompra { get; set; }
        public long Quantidade { get; set; }



        public ViewModelListaCompras()
        {
        
        }

    }
}
