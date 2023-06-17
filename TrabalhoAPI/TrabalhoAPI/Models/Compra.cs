namespace TrabalhoAPI.Models
{
    public class Compra
    {
        public long IdCompra { get; set; }
        public long IdFornecedor { get; set; }
        public long IdProduto { get; set; }
        public DateTime Data { get; set; }
        public long Quantidade { get; set; }
    }
}
