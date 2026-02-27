# Funções e figuras
library(tidyverse)
library(patchwork)
library(latex2exp)

# Define a função para criar o tema e os eixos
create_axes_theme <- function(lx, ly) {
  list(
    scale_x_continuous(
      breaks = seq(lx[1], lx[2], by = 1),
      minor_breaks = seq(lx[1], lx[2], by = 0.5),
      position = "bottom"
    ),
    scale_y_continuous(
      breaks = seq(ly[1], ly[2], by = 1),
      minor_breaks = seq(ly[1], ly[2], by = 0.5),
      position = "left"
    ),
    geom_text(data = data.frame(x = lx[1]:lx[2], y = rep(-0.5, times = length(lx[1]:lx[2]))), aes(label = x)),
    geom_text(data = data.frame(y = ly[1]:ly[2], x = rep(-0.5, times = length(ly[1]:ly[2]))), aes(label = y)),
    geom_hline(yintercept = 0, color = "black", size = 0.5),
    geom_vline(xintercept = 0, color = "black", size = 0.5),
    theme_minimal(),
    theme(
      panel.grid.major = element_line(color = "grey80", size = 0.2, linetype = 'dashed'),
      panel.grid.minor = element_blank(),
      axis.text = element_blank()
    )
  )
}

# Parâmetros
lx <- ly <- c(-10, 10)
np <- 5
sx <- lx[1]:lx[2]
sy <- ly[1]:ly[2]

# Dados
set.seed(7)
P <- tibble(x = sample(sx, size = np),
                y = sample(sy, size = np),
                o = rep(0, times = np)) |> 
  arrange(x) |> 
  mutate(lab = LETTERS[1:np]) |> 
  mutate(labv = letters[1:np])
  # mutate(labv = c(r'($\vec{a}$)',
  #                 r'($\vec{b}$)',
  #                 r'($\vec{c}$)',
  #                 r'($\vec{d}$)',
  #                 r'($\vec{e}$)'))

# Cria o gráfico
pt1 <- ggplot(data = P, aes(x, y)) +
  geom_point(size = 5, color = 'darkblue') +
  geom_segment(aes(x = 0, y = 0, xend = x, yend = y),
               arrow = arrow(length = unit(0.5, "cm")),
               color = 'red', size = 1.1) +
  geom_text(aes(label = lab, hjust = 2)) +
  geom_label(aes(x = x/2, y = y/2, label = labv), fontface = 'bold') +
  # Adiciona os componentes retornados pela função
  create_axes_theme(lx, ly)

ggsave('imagens/pt1.png', plot = pt1, width = 15, height = 15, units = 'cm')

## Vetor de ponto a ponto

P2 <- tibble(
  x = c(P$x[1], P$x[4], P$x[3]),
  y = c(P$y[1], P$y[4], P$y[3]),
  xend = c(P$x[2], P$x[5], P$x[2]),
  yend = c(P$y[2], P$y[5], P$y[2])
)

pt2 <- ggplot(data = P, aes(x, y)) +
  geom_point(size = 5, color = 'darkblue') +
  geom_text(aes(label = lab, vjust = 2.5)) +
  geom_segment(data = P2, aes(x = x, y = y, xend = xend, yend = yend),
               arrow = arrow(length = unit(0.5, "cm")),
               color = 'red', size = 1.1) +
  # Adiciona os componentes retornados pela função
  create_axes_theme(lx, ly)

ggsave('imagens/pt2.png', plot = pt2, width = 15, height = 15, units = 'cm')

####

library(ggplot2)
library(grid)      # Para usar o `unit` no `arrow()`)
library(latex2exp) # Para converter LaTeX para expressão

# Dados dos pontos
P <- data.frame(
  x = c(-4, 4, -3, 5, -9, 3),
  y = c(-2, 6, -6, 2, 4, 8),
  label = c("A", "B", "C", "D", "E", "F")
)

# Adicionar segmentos (vetores)
vectors <- data.frame(
  xstart = c(P$x[1], P$x[3], P$x[5]),
  ystart = c(P$y[1], P$y[3], P$y[5]),
  xend = c(P$x[2], P$x[4], P$x[6]),
  yend = c(P$y[2], P$y[4], P$y[6]),
  label = c("AB", "CD", "EF")
)

# Plotagem
pt3 <- ggplot(P, aes(x, y)) +
  geom_point(size = 5, color = 'darkblue') +
  geom_text(aes(label = label), vjust = -1, hjust = 0.5) +
  geom_segment(data = vectors, aes(x = xstart, y = ystart, xend = xend, yend = yend),
               arrow = arrow(length = unit(0.5, "cm")),
               color = 'red', size = 1.1) +
  geom_text(data = vectors, aes(x = (xstart + xend) / 2, y = (ystart + yend) / 2, label = label),
            vjust = -1, hjust = 0.5) +
  # theme_minimal() +
  # labs(title = "Vetores no Plano Cartesiano", x = "X", y = "Y") +
  # Adiciona os componentes retornados pela função
  create_axes_theme(lx, ly)

ggsave('imagens/pt3.png', plot = pt3, width = 15, height = 15, units = 'cm')



# Sistemas de Equações Lineares
create_axes_theme <- function(lx, ly) {
  list(
    coord_cartesian(xlim = c(lx[1], lx[2]+1), ylim = c(ly[1], ly[2]+1)),
    scale_x_continuous(name = '',
      breaks = seq(lx[1], lx[2], by = 1),
      minor_breaks = seq(lx[1], lx[2], by = 0.5),
      position = "bottom"
    ),
    scale_y_continuous(name = '',
      breaks = seq(ly[1], ly[2], by = 1),
      minor_breaks = seq(ly[1], ly[2], by = 0.5),
      position = "left"
    ),
    annotate(geom = 'text', x = lx[2]+1, y = -0.5, label =  'X', size = 6, fontface = "bold"),
    annotate(geom = 'text', y = ly[2]+1, x = -0.5, label =  'Y', size = 6, fontface = "bold"),
    geom_text(data = data.frame(x = lx[1]:lx[2], y = rep(-0.5, times = length(lx[1]:lx[2]))), aes(label = x, x = x, y = y)),
    geom_text(data = data.frame(y = ly[1]:ly[2], x = rep(-0.5, times = length(ly[1]:ly[2]))), aes(label = y, x = x, y = y)),
    geom_hline(yintercept = 0, color = "black", size = 0.5),
    geom_vline(xintercept = 0, color = "black", size = 0.5),
    theme_minimal(),
    theme(
      panel.grid.major = element_line(color = "grey80", size = 0.2, linetype = 'dashed'),
      panel.grid.minor = element_blank(),
      axis.text = element_blank()
    )
  )
}

# Crie um data frame com pontos para plotar a reta
reta_eq <- function(c1, c2, c3, x) {
  # c1 x + c2 y = c3
  y = (c3 - c1 * x) / c2
}

x_vals <- seq(-5, 5, by = 0.1)  # Intervalo de valores de x
y1_vals <- reta_eq(2, 1, 8, x_vals)
y2_vals <- reta_eq(1, -3, -3, x_vals)
y3_vals <- reta_eq(3, -9, -9, x_vals)
y4_vals <- reta_eq(1, -3, 2, x_vals)
data_reta <- data.frame(x = x_vals, y1 = y1_vals, y2 = y2_vals, 
                                    y3 = y3_vals, y4 = y4_vals)
lx <- c(-5, 5)
ly <- c(-5, 5)

sel1_retas <- ggplot(data_reta, aes(x = x_vals)) +
  geom_line(aes(y = y1_vals), color = "blue") +
  geom_line(aes(y = y2_vals), color = "red") +
  create_axes_theme(lx, ly) +
    labs(title = 'Sistema com solução única')

ggsave('imagens/sel1_retas.png', plot = sel1_retas, width = 15, height = 15, units = 'cm')


sel2_retas <- ggplot(data_reta, aes(x = x_vals)) +
  geom_line(aes(y = y2_vals), color = "blue", linewidth = 4) +
  geom_line(aes(y = y3_vals), color = "red", linewidth = 1) +
  create_axes_theme(lx, ly) +
    labs(title = 'Sistema com infinitas soluções')

ggsave('imagens/sel2_retas.png', plot = sel2_retas, width = 15, height = 15, units = 'cm')

sel3_retas <- ggplot(data_reta, aes(x = x_vals)) +
  geom_line(aes(y = y2_vals), color = "blue", linewidth = 4) +
  geom_line(aes(y = y4_vals), color = "red", linewidth = 1) +
  create_axes_theme(lx, ly) +
    labs(title = 'Sistema sem solução')

ggsave('imagens/sel3_retas.png', plot = sel3_retas, width = 15, height = 15, units = 'cm')


data_vector <- data.frame(x = c(2,1,8,6,2), y = c(1, -3, -3,3,-6))
lx <- c(-3, 8)
ly <- c(-7, 4)
sel1_vectors <- ggplot(data_vector) +
  geom_segment(aes(x = 0, y = 0, xend = x, yend = y),
                  arrow = arrow(length = unit(0.6, "cm")),
                color = c('blue', 'blue', 'red', 'blue', 'blue'),
              linetype = c('solid', 'solid', 'dashed', 'dashed', 'dashed')) +
  create_axes_theme(lx, ly)

ggsave('imagens/sel1_vectors.png', plot = sel1_vectors, width = 15, height = 15, units = 'cm')

data_vector <- data.frame(x = c(2,1,8), y = c(1, -3, -3))
lx <- c(-3, 8)
ly <- c(-7, 4)

sel2_vectors <- ggplot(data_vector, aes(x, y)) +
  geom_segment(aes(x = 0, y = 0, xend = x, yend = y),
                  arrow = arrow(length = unit(0.6, "cm")),
                color = c('blue', 'blue', 'red'),
              linetype = c('solid', 'solid', 'dashed')) +
  create_axes_theme(lx, ly) +
    labs(title = 'Sistema com solução única')
sel2_vectors

#ggsave('imagens/sel2_vectors.png', plot = sel2_vectors, width = 15, height = 15, units = 'cm')

data_vector <- data.frame(x = c(2,4,8), y = c(1, 2, 4))
lx <- c(-3, 8)
ly <- c(-7, 4)
sel3_vectors <- ggplot(data_vector, aes(x, y)) +
  geom_segment(aes(x = 0, y = 0, xend = x, yend = y),
                  arrow = arrow(length = unit(0.6, "cm")),
                  color = c('blue', 'blue', 'red'),
                  linetype = c('solid', 'solid', 'dashed')) +
  create_axes_theme(lx, ly) +
    labs(title = 'Sistema com infinitas soluções')
sel3_vectors

#ggsave('imagens/sel3_vectors.png', plot = sel3_vectors, width = 15, height = 15, units = 'cm')

data_vector <- data.frame(x = c(2,4,3), y = c(1, 2, 4))
lx <- c(-3, 8)
ly <- c(-7, 4)
sel4_vectors <- ggplot(data_vector, aes(x, y)) +
  geom_segment(aes(x = 0, y = 0, xend = x, yend = y),
                  arrow = arrow(length = unit(0.6, "cm")),
                color = c('blue', 'blue', 'red'),
              linetype = c('solid', 'solid', 'dashed'),
              linewidth = c(2,1,1) 
              ) +
  create_axes_theme(lx, ly) +
    labs(title = 'Sistema sem solução')
sel4_vectors

#ggsave('imagens/sel4_vectors.png', plot = sel4_vectors, width = 15, height = 15, units = 'cm')

res_sel <- (sel1_retas | sel2_retas | sel3_retas) / (sel2_vectors | sel3_vectors | sel4_vectors)

ggsave('imagens/res_sel.png', plot = res_sel, width = 45, height = 30, units = 'cm')

res_vec <- (sel2_vectors | sel3_vectors | sel4_vectors)

ggsave('imagens/res_vec.png', plot = res_vec, width = 45, height = 15, units = 'cm')
