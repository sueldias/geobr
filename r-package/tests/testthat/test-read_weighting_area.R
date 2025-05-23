context("read_weighting_area")


# skip tests because they take too much time
skip_if(Sys.getenv("TEST_ONE") != "")
testthat::skip_on_cran()


test_that("read_weighting_area", {

  # read data
  expect_true(is( read_weighting_area()  , "sf"))
  expect_true(is( read_weighting_area(code_weighting='all', year=2010) , "sf"))
  expect_true(is( read_weighting_area(code_weighting=11, year=2010) , "sf"))
  expect_true(is( read_weighting_area(code_weighting="AC", year=2010) , "sf"))
  expect_true(is( read_weighting_area(code_weighting="AC") , "sf"))
  expect_true(is( read_weighting_area(code_weighting=5201108, year=2010) , "sf"))
  expect_true(is( read_weighting_area(code_weighting=5201108005004, year=2010) , "sf"))

  })


# ERRORS
test_that("read_weighting_area", {

  # Wrong year and code
  testthat::expect_error(read_weighting_area(code_weighting=9999999, year=9999999))

  # Wrong code
  testthat::expect_error(read_weighting_area(code_weighting=9999999))
  testthat::expect_error(read_weighting_area(code_weighting="AC_ABCD"))

  # Wrong year
  testthat::expect_error(read_weighting_area( year=9999999))

})
