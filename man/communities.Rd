% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/communities.R
\name{communities}
\alias{communities}
\alias{communities.tna}
\alias{communities.group_tna}
\title{Community Detection for Transition Networks}
\usage{
communities(x, ...)

\method{communities}{tna}(x, methods, gamma = 1, ...)

\method{communities}{group_tna}(x, methods, gamma = 1, ...)
}
\arguments{
\item{x}{A \code{tna} or a \code{group_tna} object.}

\item{...}{Ignored.}

\item{methods}{A \code{character} vector of community detection algorithms to
apply to the network. The supported options are:
\itemize{
\item \code{"walktrap"}: A community detection method using short random walks.
\item \code{"fast_greedy"}: A method based on modularity optimization.
\item \code{"label_prop"}: A method that uses label propagation.
\item \code{"infomap"}: A method that uses information flow to detect communities.
\item \code{"edge_betweenness"}: A method that uses edge betweenness to find
communities.
\item \code{"leading_eigen"}: A method using the leading eigenvector of the
modularity matrix.
\item \code{"spinglass"}: A method based on the spinglass model.
}

If not provided, all methods are applied.}

\item{gamma}{A \code{numeric} value depicting a parameter that affects the
behavior of certain algorithms like the Spin Glass method. Defaults to \code{1}.}
}
\value{
An object of class \code{tna_communities} which is a \code{list} with an
element for each cluster containing:
\itemize{
\item \code{counts}: A \code{list} with the number of communities found
by each algorithm.
\item \code{assignments}: A \code{data.frame} where each row corresponds to a
node and each column to a community detection algorithm,
with color-coded community assignments.
}

If \code{x} is a \code{group_tna} object, a \code{group_tna_communities} object is returned
instead, which is a \code{list} of \code{tna_communities} objects.
}
\description{
This function detects communities within the transition networks
(represented by the \code{tna} object).
It uses various algorithms to find communities in the graph representation
of transitions and returns a \code{list} of communities for each cluster or a
specified cluster. If multiple transition matrices exist, the function
iterates over each cluster in the \code{tna} object to find communities using
different algorithms. The function uses the \code{igraph} package to convert
the transition matrices into graphs and then applies community detection
algorithms (e.g., Walktrap, Fast Greedy, Label Propagation, Infomap,
Edge Betweenness, Leading Eigenvector, and Spin Glass).
}
\examples{
model <- tna(group_regulation)
comm <- communities(model)

}
\seealso{
Community detection functions
\code{\link{plot.group_tna_communities}()},
\code{\link{plot.tna_communities}()},
\code{\link{print.group_tna_communities}()},
\code{\link{print.tna_communities}()}

Cluster-related functions
\code{\link{group_model}()},
\code{\link{mmm_stats}()},
\code{\link{rename_groups}()}
}
\concept{clusters}
\concept{communities}
