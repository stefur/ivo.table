# Quick and pretty frequency tables with ivo_table

![](reference/figures/logo.png)

## Background

R has some great packages for creating nice-looking tables. Packages
like `gt` and `flextable` allow the user to create a wide range of
tables, with lots of flexibility in how these are presented and
formatted. The downside to these Swiss army knife-style packages is that
simple tasks, like creating a frequency table, require a lot of typing.
Enter `ivo.table`, a package for creating great-looking frequency tables
and contingency tables without any hassle.

The package offers two functions for creating tables: `ivo_table`, which
uses the `flextable` framework, and `ivo_table_gt` which uses the `gt`
framework. This vignette contains examples using the former.

## A first example

Let’s look at some examples using the `penguins` data from the
[`palmerpenguins`](https://cran.r-project.org/package=palmerpenguins)
package. Say that we want to create a contingency table showing the
counts of the categorical variables `species`, `sex`, and `island`. We
can use `ftable` along with `dplyr`’s `select`:

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(palmerpenguins)
#> 
#> Attaching package: 'palmerpenguins'
#> The following objects are masked from 'package:datasets':
#> 
#>     penguins, penguins_raw

penguins |> select(species, sex, island) |> ftable()
#>                  island Biscoe Dream Torgersen
#> species   sex                                 
#> Adelie    female            22    27        24
#>           male              22    28        23
#> Chinstrap female             0    34         0
#>           male               0    34         0
#> Gentoo    female            58     0         0
#>           male              61     0         0
```

While informative, the formatting isn’t great, and it’s not something
that we can easily export to a report or presentation.

`ivo.table` uses the same syntax, but with `ivo_table` instead of
`ftable`:

``` r
library(ivo.table)

penguins |> select(species, sex, island) |> ivo_table()
```

|           |           | species |       |           |
|-----------|-----------|---------|-------|-----------|
| sex       | island    | Biscoe  | Dream | Torgersen |
| Adelie    | female    | 22      | 27    | 24        |
|           | male      | 22      | 28    | 23        |
|           | (Missing) | 0       | 1     | 5         |
| Chinstrap | female    | 0       | 34    | 0         |
|           | male      | 0       | 34    | 0         |
|           | (Missing) | 0       | 0     | 0         |
| Gentoo    | female    | 58      | 0     | 0         |
|           | male      | 61      | 0     | 0         |
|           | (Missing) | 5       | 0     | 0         |

The resulting table can easily be exported to a Word document:

``` r
penguins |>
  select(species, sex, island) |>
  ivo_table() |> 
  flextable::save_as_docx(path = "example_table.docx")
```

You can add row and column sums:

``` r
penguins |>
  select(species, sex, island) |>
  ivo_table(colsums = TRUE,
            rowsums = TRUE)
```

|           |           | species |       |           |       |
|-----------|-----------|---------|-------|-----------|-------|
| sex       | island    | Biscoe  | Dream | Torgersen | Total |
| Adelie    | female    | 22      | 27    | 24        | 73    |
|           | male      | 22      | 28    | 23        | 73    |
|           | (Missing) | 0       | 1     | 5         | 6     |
| Chinstrap | female    | 0       | 34    | 0         | 34    |
|           | male      | 0       | 34    | 0         | 34    |
|           | (Missing) | 0       | 0     | 0         | 0     |
| Gentoo    | female    | 58      | 0     | 0         | 58    |
|           | male      | 61      | 0     | 0         | 61    |
|           | (Missing) | 5       | 0     | 0         | 5     |
| Total     |           | 168     | 124   | 52        | 344   |

Or show percentages instead of counts, e.g. computed by column:

``` r
penguins |>
  select(species, sex, island) |>
  ivo_table(percent_by = "col")
```

|           |           | species |        |           |
|-----------|-----------|---------|--------|-----------|
| sex       | island    | Biscoe  | Dream  | Torgersen |
| Adelie    | female    | 13,1 %  | 21,8 % | 46,2 %    |
|           | male      | 13,1 %  | 22,6 % | 44,2 %    |
|           | (Missing) | 0,0 %   | 0,8 %  | 9,6 %     |
| Chinstrap | female    | 0,0 %   | 27,4 % | 0,0 %     |
|           | male      | 0,0 %   | 27,4 % | 0,0 %     |
|           | (Missing) | 0,0 %   | 0,0 %  | 0,0 %     |
| Gentoo    | female    | 34,5 %  | 0,0 %  | 0,0 %     |
|           | male      | 36,3 %  | 0,0 %  | 0,0 %     |
|           | (Missing) | 3,0 %   | 0,0 %  | 0,0 %     |

## Changing the appearance of your tables

`ivo_table` has lots of options for customising the look of your table.
You can change the colours and fonts used, highlight columns, rows or
cells, make columns bold, and more. Let’s look at some examples.

Change the font to Courier, use red instead of green, and make the names
in the `sex` column bold:

``` r
penguins |>
  select(species, sex, island) |>
  ivo_table(color = "red",
            font_name = "Courier",
            bold_cols = 1)
```

|           |           | species |       |           |
|-----------|-----------|---------|-------|-----------|
| sex       | island    | Biscoe  | Dream | Torgersen |
| Adelie    | female    | 22      | 27    | 24        |
|           | male      | 22      | 28    | 23        |
|           | (Missing) | 0       | 1     | 5         |
| Chinstrap | female    | 0       | 34    | 0         |
|           | male      | 0       | 34    | 0         |
|           | (Missing) | 0       | 0     | 0         |
| Gentoo    | female    | 58      | 0     | 0         |
|           | male      | 61      | 0     | 0         |
|           | (Missing) | 5       | 0     | 0         |

Add a caption and highlight the cell on the fourth row of the third
column:

``` r
penguins |>
  select(species, sex, island) |>
  ivo_table(caption = "A table with penguins in it",
            highlight_cols = 3,
            highlight_rows = 4)
```

|           |           | species |       |           |
|-----------|-----------|---------|-------|-----------|
| sex       | island    | Biscoe  | Dream | Torgersen |
| Adelie    | female    | 22      | 27    | 24        |
|           | male      | 22      | 28    | 23        |
|           | (Missing) | 0       | 1     | 5         |
| Chinstrap | female    | 0       | 34    | 0         |
|           | male      | 0       | 34    | 0         |
|           | (Missing) | 0       | 0     | 0         |
| Gentoo    | female    | 58      | 0     | 0         |
|           | male      | 61      | 0     | 0         |
|           | (Missing) | 5       | 0     | 0         |

A table with penguins in it

`ivo_table` returns a `flextable` object, meaning that all [functions
used to style
flextables](https://ardata-fr.github.io/flextable-book/define-visual-properties.html)
can be used. For instance, you can change the font size used in
different parts of the table using
[`flextable::fontsize`](https://davidgohel.github.io/flextable/reference/fontsize.html)
and change the background colour using
[`flextable::bg`](https://davidgohel.github.io/flextable/reference/bg.html):

``` r
penguins |>
  select(species, sex, island) |>
  ivo_table(color = "darkblue") |> 
  flextable::fontsize(size = 8, part = "body") |> 
  flextable::fontsize(size = 12, part = "header") |> 
  flextable::bg(bg = "pink", part = "all")
```

|           |           | species |       |           |
|-----------|-----------|---------|-------|-----------|
| sex       | island    | Biscoe  | Dream | Torgersen |
| Adelie    | female    | 22      | 27    | 24        |
|           | male      | 22      | 28    | 23        |
|           | (Missing) | 0       | 1     | 5         |
| Chinstrap | female    | 0       | 34    | 0         |
|           | male      | 0       | 34    | 0         |
|           | (Missing) | 0       | 0     | 0         |
| Gentoo    | female    | 58      | 0     | 0         |
|           | male      | 61      | 0     | 0         |
|           | (Missing) | 5       | 0     | 0         |
