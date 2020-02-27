#' What is a plot?
#'
#' This type of graphic presents data in a visual manner.
#'
#' @inheritParams whatr_scores
#' @return A ggplot object.
#' @examples
#' whatr_plot(game = 6304)
#' whatr_html("2019-06-04", "showscores") %>% whatr_plot()
#' @importFrom xml2 read_html
#' @importFrom rvest html_node html_text
#' @importFrom stringr str_extract str_remove
#' @importFrom tidyr drop_na
#' @importFrom dplyr filter mutate
#' @importFrom ggplot2 ggplot aes geom_vline geom_line scale_y_continuous
#'   scale_x_continuous scale_color_brewer labs scale_shape_discrete
#' @export
whatr_plot <- function(game) {
  if (is(game, "xml_document") & !grepl("ddred", as.character(game))) {
    game <- whatr_html(x = game, out = "showscores")
  } else if (!is(game, "xml_document")) {
    game <- whatr_html(x = game, out = "showscores")
  }

  id <- as.character(game) %>%
    stringr::str_extract("(?<=chartgame.php\\?game_id\\=)\\d+")
  scores <- whatr_scores(game) %>%
    dplyr::group_by(name) %>%
    dplyr::mutate(run = cumsum(score)) %>%
    dplyr::ungroup()
  subtitle <- game %>%
    rvest::html_node("title") %>%
    rvest::html_text() %>%
    stringr::str_remove(".*-\\s")
  finals <- dplyr::filter(scores, round == 3)
  doubles <- dplyr::filter(scores, double)
  finals$n <- finals$n + 2
  plot <- scores %>%
    dplyr::filter(round != 3) %>%
    ggplot2::ggplot(mapping = ggplot2::aes(x = n, y = run)) +
    ggplot2::geom_vline(xintercept = max(scores$n[scores$round == 1]), linetype = 2) +
    ggplot2::geom_vline(xintercept = max(scores$n[scores$round == 2]), linetype = 2) +
    ggplot2::geom_line(mapping = ggplot2::aes(color = name), size = 2) +
    ggplot2::geom_point(data = doubles, size = 3, mapping = ggplot2::aes(shape = name)) +
    ggplot2::geom_point(data = finals, size = 6, shape = 18, mapping = ggplot2::aes(color = name)) +
    ggplot2::scale_y_continuous(labels = scales::dollar) +
    ggplot2::scale_x_continuous(breaks = seq(0, 60, 10)) +
    ggplot2::scale_color_brewer(palette = "Dark2") +
    ggplot2::scale_shape_discrete(guide = FALSE) +
    ggplot2::labs(
      title = "Jeopardy! Game Score History",
      subtitle = subtitle,
      caption = paste("Souce: J! Archive:", id),
      color = "Contestant",
      y = "Score",
      x = "Clue"
    )
  return(plot)
}