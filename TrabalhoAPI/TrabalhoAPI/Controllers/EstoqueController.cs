using Microsoft.AspNetCore.Mvc;
using TrabalhoAPI.Models;
using TrabalhoAPI.Models.ViewModels;
using TrabalhoAPI.Repositories;
using Microsoft.AspNetCore.Authorization;

namespace ApiEstoque.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class EstoqueController : ControllerBase
    {
        private readonly ILogger<EstoqueController> _logger;
        public EstoqueController(ILogger<EstoqueController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        
        [Route("consultar/estoques")]
        public ActionResult<List<Estoque>> ConsultarEstoquesCadastrados()
        {
            try
            {
                _logger.LogInformation("Consultando estoque no banco de dados");

                var estoques = EstoqueRepository.ConsultarEstoquesCadastrados();

                if (estoques.Count < 1)
                    return NotFound("Estoques não encontrados.");

                return Ok(estoques);
            }
            catch (Exception ex)
            {
                _logger.LogError("Erro ao executar o método ConsultarEstoquesCadastrados(): {ex.Message}", ex.Message);

                return BadRequest("Ocorreu um erro ao consultar estoques");
            }

        }

        [HttpGet]
       
        [Route("/consultar/tipos/movimentacoesEstoque")]
        public ActionResult<List<TiposMovimentacoesEstoque>> ConsultaTiposMovimentacoesEstoque()
        {
            try
            {
                _logger.LogInformation("Consultando estoque no banco de dados");

                var tiposMovimentacoes = EstoqueRepository.ConsultarTiposMovimentacaoEstoque();

                if (tiposMovimentacoes.Count < 1)
                    return NotFound("Estoque não encontrado. Verifique ID.");

                return Ok(tiposMovimentacoes);
            }
            catch (Exception ex)
            {
                _logger.LogError("Erro ao executar o método ConsultarEstoque(): {ex.Message}", ex.Message);

                return BadRequest("Ocorreu um erro ao consultar estoque");
            }

        }


        [HttpPost]
        [Route("/registrar/movimentacaoEstoque")]
        public ActionResult RegistrarMovimentacaoEstoque([FromBody] MovimentacaoEstoque movimentacaoEstoque)
        {
            try
            {
                _logger.LogInformation("Registrando movimentação de estoque no banco de dados");


                var resultado = 0;

                if (movimentacaoEstoque.IdTipoMovimentacaoEstoque == 1)
                {
                    resultado = EstoqueRepository.RegistrarMovimentacaoEntradaArmazem(movimentacaoEstoque);

                    if (resultado < 1)
                        return BadRequest("Não foi possível registrar entrada no armazém.");

                    return Ok(resultado);

                }
                else
                {
                    if (movimentacaoEstoque.IdEstoqueRecebedor == movimentacaoEstoque.IdEstoqueSaida)
                        return BadRequest("Não é possível realizar movimentações.");

                    var estoqueSaida = ProdutosRepository.ConsultarProdutosEmEstoque(movimentacaoEstoque.IdEstoqueSaida);

                    bool produtoExisteNoEstoque = false;

                    foreach (var produto in estoqueSaida)
                    {
                        if (produto.IdProduto == movimentacaoEstoque.IdProduto)
                        {
                            produtoExisteNoEstoque = true;

                            if (produto.Quantidade < movimentacaoEstoque.Quantidade)
                                return Conflict("Quantidade da movimentação é maior do que a disponibilidade do estoque.");

                        }
                    }

                    if (!produtoExisteNoEstoque)
                      return NotFound("Produto não existe no estoque de saída.");

                    resultado = EstoqueRepository.RegistrarMovimentacaoEntreEstoques(movimentacaoEstoque);

                    if (resultado < 2)
                        return Problem("Ocorreu um erro no registro das movimentações.");

                    return Ok(resultado);
                }

            }
            catch (Exception ex)
            {
                _logger.LogError("Erro ao executar o método RegistrarMovimentacaoEstoque(): {ex.Message}", ex.Message);

                return BadRequest("Ocorreu um erro ao registrar a movimentação");
            }
        }





        [HttpGet]
        
        [Route("/consultar/disponibilidade/{codBarras}")]
        public ActionResult<List<ViewModelDisponibilidadeProdutosPorEstoque>> ConsultarDisponibilidadeProdutoPorEstoque(string codBarras)
        {
            try
            {
                _logger.LogInformation("Consultando disponibilidade do produto nos estoques.");

                var produtos = new List<ViewModelDisponibilidadeProdutosPorEstoque>();
                var estoqueArmazem = ProdutosRepository.ConsultarProdutosEmEstoque(5);
                var estoqueVenda = ProdutosRepository.ConsultarProdutosEmEstoque(4);
                var estoqueTroca = ProdutosRepository.ConsultarProdutosEmEstoque(6);

                foreach (var p in estoqueArmazem)
                {
                    if (p.CodBarras == codBarras)
                    {
                        var produto = new ViewModelDisponibilidadeProdutosPorEstoque()
                        {
                            idEstoque = 5,
                            IdProduto = p.IdProduto,
                            descricao = p.Descricao,
                            codBarras = p.CodBarras,
                            Quantidade = p.Quantidade
                        };
                        produtos.Add(produto);
                    }
                }
                foreach (var p in estoqueVenda)
                {
                    if (p.CodBarras == codBarras)
                    {
                        var produto = new ViewModelDisponibilidadeProdutosPorEstoque()
                        {
                            idEstoque = 4,
                            IdProduto = p.IdProduto,
                            descricao = p.Descricao,
                            codBarras = p.CodBarras,
                            Quantidade = p.Quantidade
                        };
                        produtos.Add(produto);
                    }
                    
                }
                foreach (var p in estoqueTroca)
                {
                    if (p.CodBarras == codBarras)
                    {
                        var produto = new ViewModelDisponibilidadeProdutosPorEstoque()
                        {
                            idEstoque = 6,
                            IdProduto = p.IdProduto,
                            descricao = p.Descricao,
                            codBarras = p.CodBarras,
                            Quantidade = p.Quantidade
                        };
                        produtos.Add(produto);
                    }
                }

                if (produtos.Count < 1)
                    return BadRequest("Produto não encontrado nos estoques.");

                return produtos;
            }
            catch (Exception ex)
            {
                _logger.LogError("Erro ao executar o método ConsultarEstoque(): {ex.Message}", ex.Message);

                return BadRequest("Ocorreu um erro ao consultar estoque");
            }

        }


        [HttpGet]

        [Route("/consultar/disponibilidade/all")]
        public ActionResult<List<ViewModelDisponibilidadeProdutosPorEstoque>> ConsultarDisponibilidadeProdutoPorEstoque()
        {
            try
            {
                _logger.LogInformation("Consultando disponibilidade do produto nos estoques.");

                var produtos = new List<ViewModelDisponibilidadeProdutosPorEstoque>();
                var estoqueArmazem = ProdutosRepository.ConsultarProdutosEmEstoque(5);
                var estoqueVenda = ProdutosRepository.ConsultarProdutosEmEstoque(4);
                var estoqueTroca = ProdutosRepository.ConsultarProdutosEmEstoque(6);

                foreach (var p in estoqueArmazem)
                {
                        var produto = new ViewModelDisponibilidadeProdutosPorEstoque()
                        {
                            idEstoque = 5,
                            IdProduto = p.IdProduto,
                            descricao = p.Descricao,
                            codBarras = p.CodBarras,
                            Quantidade = p.Quantidade
                        };
                        produtos.Add(produto);
                }
                foreach (var p in estoqueVenda)
                {

                        var produto = new ViewModelDisponibilidadeProdutosPorEstoque()
                        {
                            idEstoque = 4,
                            IdProduto = p.IdProduto,
                            descricao = p.Descricao,
                            codBarras = p.CodBarras,
                            Quantidade = p.Quantidade
                        };
                        produtos.Add(produto);

                }
                foreach (var p in estoqueTroca)
                {

                        var produto = new ViewModelDisponibilidadeProdutosPorEstoque()
                        {
                            idEstoque = 6,
                            IdProduto = p.IdProduto,
                            descricao = p.Descricao,
                            codBarras = p.CodBarras,
                            Quantidade = p.Quantidade
                        };
                        produtos.Add(produto); 
                }

                if (produtos.Count < 1)
                    return BadRequest("Produto não encontrado nos estoques.");

                return produtos;
            }
            catch (Exception ex)
            {
                _logger.LogError("Erro ao executar o método ConsultarEstoque(): {ex.Message}", ex.Message);

                return BadRequest("Ocorreu um erro ao consultar estoque");
            }

        }
    }
}

            

        