require(testthat)
context("vertical_distance function")

test_that("the vertical_distance function works with double arguments", {

  from_alt <- 22222.22
  to_alt <- 33333.33
  result <- vertical_distance(from_alt = from_alt, to_alt = to_alt)

  expect_true(is.matrix(result))

  # The result has units of "m" (metres).
  expect_true(inherits(result, "units"))
  expect_equal(units(result)[["numerator"]], expected = "m")
  expect_equal(units(result)[["denominator"]], expected = character(0))

  # The value of the result is the diffence *in metres*.
  expect_equal(as.double(result), expected = 11111.11/3.28084, tolerance = 1e-6)
})

test_that("the vertical_distance function works with first double argument", {

  from_alt <- 22222.22
  to_alt <- set_units(33333.33, "ft")
  result <- vertical_distance(from_alt = from_alt, to_alt = to_alt)

  # The result has units of "m" (metres).
  expect_true(inherits(result, "units"))
  expect_equal(units(result)[["numerator"]], expected = "m")
  expect_equal(units(result)[["denominator"]], expected = character(0))

  # The value of the result is the diffence *in metres*.
  expect_equal(as.double(result), expected = 11111.11/3.28084, tolerance = 1e-6)
})

test_that("the vertical_distance function works with second double argument", {

  from_alt <- set_units(22222.22, "ft")
  to_alt <- 33333.33
  result <- vertical_distance(from_alt = from_alt, to_alt = to_alt)

  # The result has units of "m" (metres).
  expect_true(inherits(result, "units"))
  expect_equal(units(result)[["numerator"]], expected = "m")
  expect_equal(units(result)[["denominator"]], expected = character(0))

  # The value of the result is the diffence *in metres*.
  expect_equal(as.double(result), expected = 11111.11/3.28084, tolerance = 1e-6)
})

test_that("the vertical_distance function works with no double arguments", {

  from_alt <- set_units(22222.22, "ft")
  to_alt <- set_units(33333.33, "ft")
  result <- vertical_distance(from_alt = from_alt, to_alt = to_alt)

  # The result has units of "m" (metres).
  expect_true(inherits(result, "units"))
  expect_equal(units(result)[["numerator"]], expected = "m")
  expect_equal(units(result)[["denominator"]], expected = character(0))

  # The value of the result is the diffence *in metres*.
  expect_equal(as.double(result), expected = 11111.11/3.28084, tolerance = 1e-6)
})

test_that("the vertical_distance function works with different unit arguments", {

  from_alt <- set_units(22222.22, "ft")
  to_alt <- set_units(33333.33/3.28084, "m")
  result <- vertical_distance(from_alt = from_alt, to_alt = to_alt)

  # The result has units of "m" (metres).
  expect_true(inherits(result, "units"))
  expect_equal(units(result)[["numerator"]], expected = "m")
  expect_equal(units(result)[["denominator"]], expected = character(0))

  # The value of the result is the diffence *in metres*.
  expect_equal(as.double(result), expected = 11111.11/3.28084, tolerance = 1e-6)
})

test_that("the vertical_distance function works with vector arguments", {

  from_alt <- set_units(c(11111.11, 22222.22, 33333.33), "ft")
  to_alt <- set_units(c(11111.11, 22222.22, 33333.33, 44444.44)/3.28084, "m")
  result <- vertical_distance(from_alt = from_alt, to_alt = to_alt)

  expect_true(is.matrix(result))
  expect_equal(dim(result), expected = c(length(from_alt), length(to_alt)))

  # The result has units of "m" (metres).
  expect_true(inherits(result, "units"))
  expect_equal(units(result)[["numerator"]], expected = "m")
  expect_equal(units(result)[["denominator"]], expected = character(0))

  # The value of the result is the difference *in metres*.
  expect_equal(as.double(result[1, 1]), expected = 0, tolerance = 1e-3)
  expect_equal(as.double(result[1, 2]), expected = 11111.11/3.28084, tolerance = 1e-6)
  expect_equal(as.double(result[1, 3]), expected = 22222.22/3.28084, tolerance = 1e-6)
  expect_equal(as.double(result[1, 4]), expected = 33333.33/3.28084, tolerance = 1e-6)

  expect_equal(as.double(result[3, 1]), expected = -22222.22/3.28084, tolerance = 1e-6)
  expect_equal(as.double(result[3, 2]), expected = -11111.11/3.28084, tolerance = 1e-6)
  expect_equal(as.double(result[3, 3]), expected = 0, tolerance = 1e-3)
  expect_equal(as.double(result[3, 4]), expected = 11111.11/3.28084, tolerance = 1e-6)
})

