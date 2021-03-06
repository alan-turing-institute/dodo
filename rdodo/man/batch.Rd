% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/batch.R
\name{batch}
\alias{batch}
\title{Submit a batch of calls to the Bluebird API asynchronously.}
\usage{
batch(..., async = TRUE)
}
\arguments{
\item{...}{One or more API function calls.}

\item{async}{A boolean flag. Defaults to \code{TRUE}, in which case the calls are
dispatched asynchronously.}
}
\value{
A list of return values, one for each of the given function calls, if all are
successful. Otherwise an error is thrown containing the conconcated error
messages from all of the failed function calls, separated by a semicolon.
}
\description{
This function mitigates the problem of unresponsiveness when submitting
multiple API calls in quick succession. By wrapping the calls in the
\code{batch} function they are dispatched asynchronous to minimise blocking.
}
\examples{
\dontrun{
reset_simulation()
create_aircraft("ABC",type="B741",latitude=0,longitude=0,heading=0,flight_level=200,speed=250)
create_aircraft("XYZ",type="B744",latitude=0,longitude=0,heading=0,flight_level=300,speed=350)
batch(
  change_heading("ABC", heading = 350),
  change_altitude("ABC", flight_level = 450),
  change_heading("XYZ", heading = 10),
  change_altitude("XYZ", flight_level = 250)
)
}

}
