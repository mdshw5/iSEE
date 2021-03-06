% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/defaults.R
\name{defaults}
\alias{defaults}
\alias{redDimPlotDefaults}
\alias{featExprPlotDefaults}
\alias{colDataPlotDefaults}
\alias{rowStatTableDefaults}
\alias{rowDataPlotDefaults}
\alias{heatMapPlotDefaults}
\title{Parameter defaults}
\usage{
redDimPlotDefaults(se, number)

featExprPlotDefaults(se, number)

colDataPlotDefaults(se, number)

rowStatTableDefaults(se, number)

rowDataPlotDefaults(se, number)

heatMapPlotDefaults(se, number)
}
\arguments{
\item{se}{A SingleCellExperiment object.}

\item{number}{An integer scalar, specifying the maximum number of 
panels of the corresponding type that can be added to the interface.}
}
\value{
A DataFrame containing default settings for various parameters of each panel.
}
\description{
Create default settings for various panels in the iSEE interface.
}
\section{Reduced dimension plot parameters}{

\describe{
\item{\code{Type}:}{Integer, which entry of \code{reducedDims(se)} should be shown?
Defaults to 1, i.e., the first entry.
Alternatively, a string can be supplied containing the name of the reduced dimension field, if \code{reducedDims(se)} has names.}
\item{\code{XAxis}:}{Integer, which component should be shown on the x-axis?
Defaults to 1.}
\item{\code{YAxis}:}{Integer, which component should be shown on the y-axis?
Defaults to 2.}
}
}

\section{Feature expression plot parameters}{

\describe{
\item{\code{RowTable}:}{Character, what row statistic table should be used to choose a feature to display on the y-axis?
Defaults to \code{"---"}, which means that the first available table will be used.}
\item{\code{Assay}:}{Integer, which assay should be used to supply the expression values shown on the y-axis?
Defaults to 1, i.e., the first assay in \code{se}.
Alternatively, a string can also be supplied containing the name of the assay, if \code{assays(se)} has names.}
\item{\code{YAxis}:}{Character, what type of variable should be shown on the x-axis?
Defaults to \code{"Row table"}, but can also be \code{"Feature name"}.}
\item{\code{YAxisFeatName}:}{Integer, the index of the feature for which to show the expression on the y-axis if \code{YAxis="Feature name"}. 
Defaults to 1, i.e., the first feature in \code{se}.
Alternatively, a string can be supplied containing the name of the feature, i.e., the row name.}
\item{\code{YAxisRowTable}:}{Character, which row statistic table should be used to choose a feature to put on the y-axis if \code{YAxis="Row table"}? 
Defaults to an empty string, which means that the first available table will be used.}
\item{\code{XAxis}:}{Character, what type of variable should be shown on the x-axis?
Defaults to \code{"None"}, but can also be \code{"Row table"}, \code{"Column data"} or \code{"Feature name"}.}
\item{\code{XAxisColData}:}{Character, what column of \code{colData(se)} should be shown on the x-axis if \code{XAxis="Column data"}?
Defaults to the first entry of \code{colData(se)}.}
\item{\code{XAxisFeatName}:}{Integer, the index of the feature for which to show the expression on the x-axis if \code{XAxis="Feature name"}. 
Defaults to 1, i.e., the first feature in \code{se}.
Alternatively, a string can be supplied containing the name of the feature.}
\item{\code{XAxisRowTable}:}{Character, which row statistic table should be used to choose a feature to put on the x-axis if \code{XAxis="Row table"}? 
Defaults to an empty string, which means that the first available table will be used.}
}
}

\section{Column data plot parameters}{

\describe{
\item{\code{YAxis}:}{Character, which column of \code{colData(se)} should be shown on the y-axis?
Defaults to the first entry of \code{colData(se)}.}
\item{\code{XAxis}:}{Character, what type of variable should be shown on the x-axis?
Defaults to \code{"None"}, but can also be \code{"Column data"}.}
\item{\code{XAxisColData}:}{Character, which column of \code{colData(se)} should be shown on the x-axis if \code{XAxis="Column data"}?
Defaults to the first entry of \code{colData(se)}.}
}
}

\section{Row data plot parameters}{

\describe{
\item{\code{YAxis}:}{Character, which column of \code{rowData(se)} should be shown on the y-axis?
Defaults to the first entry of \code{colData(se)}.}
\item{\code{XAxis}:}{Character, what variable should be shown on the x-axis?
Defaults to \code{"None"}, but can also be \code{"Row table"}, \code{"Row data"} or \code{"Feature name"}.}
\item{\code{XAxisRowData}:}{Character, which column of \code{rowData(se)} should be shown on the x-axis if \code{XAxis="Row data"}?
Defaults to the first entry of \code{rowData(se)}.}
}
}

\section{Coloring parameters}{

For the plots where each point represents a sample (i.e., all plots except for row data plots), the following options apply:
\describe{
\item{\code{ColorPanelOpen}:}{Logical, should the color parameter panel be open upon initialization?
Defaults to \code{FALSE}.}
\item{\code{ColorBy}:}{Character, what type of data should be used for coloring?
Defaults to \code{"None"}, but can also be \code{"Row table"}, \code{"Feature name"} or \code{"Column data"}.}
\item{\code{ColorByColData}:}{Character, which column of \code{colData(se)} should be used for colouring if \code{ColorBy="Column data"}? 
Defaults to the first entry of \code{colData(se)}.}
\item{\code{ColorByRowTable}:}{Character, which row statistic table should be used to choose a feature to color by, if \code{ColorBy="Row table"}? 
Defaults to an empty string, which means that the first available table will be used.}
\item{\code{ColorByRowTableAssay}:}{Integer, which assay should be used to supply the expression values for colouring if \code{ColorBy="Row table"}? 
Defaults to 1, i.e., the first assay in \code{se}.
Alternatively, a string can also be supplied containing the name of the assay, if \code{assays(se)} has names.}
\item{\code{ColorByFeatName}:}{Integer, the index of the feature to use for colouring based on expression, if \code{ColorBy="Feature name"}? 
Defaults to 1, i.e., the first feature in \code{se}.
Alternatively, a string can be supplied containing the name of the feature.}
\item{\code{ColorByFeatNameAssay}:}{Integer, which assay should be used to supply the expression values for colouring if \code{ColorBy="Feature name"}? 
Defaults to 1, i.e., the first assay in \code{se}.
Alternatively, a string can also be supplied containing the name of the assay, if \code{assays(se)} has names.}
}
For row data plots, the following options apply:
\describe{
\item{\code{ColorPanelOpen}:}{Logical, should the color parameter panel be open upon initialization?
Defaults to \code{FALSE}.}
\item{\code{ColorBy}:}{Character, what type of data should be used for coloring?
Defaults to \code{"None"}, but can also be \code{"Row table"}, \code{"Feature name"} or \code{"Row data"}.}
\item{\code{ColorByRowData}:}{Character, which column of \code{rowData(se)} should be used for colouring if \code{ColorBy="Row data"}? 
Defaults to the first entry of \code{rowData(se)}.}
\item{\code{ColorByRowTable}:}{Character, which row statistic table should be used to choose a feature to color by, if \code{ColorBy="Row table"}? 
Defaults to an empty string, which means that the first available table will be used.}
\item{\code{ColorByRowTableColor}:}{String specifying the colour to be used to highlight the selected feature from the row table.
Defaults to \code{"red"}.}
\item{\code{ColorByFeatName}:}{Integer, the index of the feature to use for colouring based on expression, if \code{ColorBy="Feature name"}? 
Defaults to 1, i.e., the first feature in \code{se}.
Alternatively, a string can be supplied containing the name of the feature.}
\item{\code{ColorByFeatNameColor}:}{String specifying the colour to be used to highlight the selected feature from the text.
Defaults to \code{"red"}.}
}
}

\section{Brushing parameters}{

For the plots, the following options apply:
\describe{
\item{\code{BrushPanelOpen}:}{Logical, should the brushing parameter panel be open upon initialization?
Defaults to \code{FALSE}.}
\item{\code{BrushByPlot}:}{Character, which other plot should be used for point selection in the current plot? 
Defaults to \code{"---"}, which means that no plot is used for point selection.}
\item{\code{BrushEffect}:}{Character, what is the effect of receiving a brush input?
Can be \code{"Restrict"}, where only the brushed points are shown; \code{"Color"}, where the brushed points have a different color; 
or \code{"Transparent"}, where all points other than the brushed points are made transparent. Defaults to \code{"Transparent"}.}
\item{\code{BrushColor}:}{Character, what color should be used for the brushed points when \code{BrushEffect="Color"}?
Defaults to \code{"red"}.}
\item{\code{BrushAlpha}:}{Numeric, what level of transparency should be used for the unbrushed points whe \code{BrushEffect="Transparent"}?
This should lie in [0, 1], where 0 is fully transparent and 1 is fully opaque. 
Defaults to 0.1.}
}

Note that brushing cannot occur between row data plots and the other plot types.
This is because each point in a row data plot is a feature, while each point represents a sample in the other plots.

For the row statistics tables, the following options apply:
\describe{
\item{\code{BrushPanelOpen}:}{Logical, should the brushing parameter panel be open upon initialization?
Defaults to \code{FALSE}.}
\item{\code{BrushByPlot}:}{Character, which other plot should be used to select features in the current table? 
Defaults to \code{"---"}, which means that no plot is used for point selection.}
}
Only row data plots can be used for brushing of tables.
}

\section{Other plot parameters}{

\describe{
\item{\code{PlotPanelOpen}:}{Logical, should the plot parameter panel be open upon initialization?
Defaults to \code{FALSE}.}
\item{\code{ZoomData}:}{A list containing numeric vectors of length 4, containing values with names \code{"xmin"}, \code{"xmax"}, \code{"ymin"} and \code{"ymax"}.
These define the zoom window on the x- and y-axes.
Each element of the list defaults to \code{NULL}, i.e., no zooming is performed.}
}
}

\section{Row statistics table parameters}{

\describe{
\item{\code{Selected}:}{Integer, containing the index of the row to be initially selected.
Defaults to the first row, i.e., 1.
Alternatively, a string can be supplied containing the row name.}
\item{\code{Search}:}{Character, containing the initial value of the search field.
Defaults to an empty string.}
\item{\code{SearchColumns}:}{A list containing character vectors of length equal to the number of columns in \code{rowData(se)},
specifying the initial value of the search field for each column.
All entries default to an empty string.}
}
}

\examples{
library(scRNAseq)
data(allen)
class(allen)

library(scater)
sce <- as(allen, "SingleCellExperiment")
counts(sce) <- assay(sce, "tophat_counts")
sce <- normalize(sce)
sce <- runPCA(sce)
sce

redDimPlotDefaults(sce, number=5)
featExprPlotDefaults(sce, number=5)
colDataPlotDefaults(sce, number=5)
rowStatTableDefaults(sce, number=5)
rowDataPlotDefaults(sce, number=5)
heatMapPlotDefaults(sce, number=5)
}
