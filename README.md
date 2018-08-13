# melbourne-datathon
Melbourne datathon - Saved by the Bell Curve Team 2018

## Master doc:

- [Data summary]
- [MindMap]
- [Master doc]
- The [original data]
- Chat at [fleep]
- [datathon FAQ]

## Contributing Styleguide:

#### Commiting with Github:

[Github tldr]

#### We're styling like this:

https://github.com/tgrrr/data-science/blob/master/R/R-Styleguide.md

#### tl;dr

```{r}
# timeseries-analysis.R - filename-is-separated-by-dashes.R
FunctionName() <- function(
  variable_name <- "is descriptive and uses_underscores"
)
FunctionName(argument = "foo", argument = "bar")
```

- 2 Spaces indentation
- pipe where possible

#### Naming

- `timeseries-analysis.R` - filenames
- `GetRatioDiscrepancies()` - function names
- `some_measure_uncleaned` - variable StopNameShort

## The app

### R server

run `R/index.R`

Data is served as an api using [Plumber] to:

`http://localhost:8888/demo` - serves basic json to page

The returned json can be edited at:

`melbourne-datathon/R/pages/demo-api__json.R`

## installation
TODO:

1. clone this repo:
```
git clone https://github.com/tgrrr/melbourne-datathon.git
```
2. Install node modules
```
cd melbourne-datathon
cd react
npm install
```

### React as a frontend

Starting the app:

```
cd react
npm run start
```

The pages can be edited at:

`react/src/pages/Home/Home.js`




### This project was bootstrapped with:

- [Plumber]
- R
- [Create React App]

<!-- Links below here -->
[Plumber]: https://www.rplumber.io/docs/index.html
[Create React App]: https://github.com/facebook/create-react-app

<!-- Our working docs: -->
[Data summary]: https://docs.google.com/spreadsheets/d/1PcS6gzvsOFHVTtynRIkdGUV83lzN-5GH13EiGQkYsnI/edit#gid=749113941
[MindMap]: https://coggle.it/diagram/W1vA8k8sWFISnXMs/t/datathon-melbourne

<!-- What we started with: -->
[original data]: https://www.dropbox.com/sh/lnlpa5otyhw2k9n/AAAmIJ2KhhLqhEiAT8WVqJBda?dl=0
[fleep]: https://fleep.io/chat?cid=YvWknF-qRW-HDaRsOZOMXw
[datathon FAQ]: http://www.datasciencemelbourne.com/datathon/hackday-1-other-info/
[Github tldr]: https://github.com/tgrrr/tldr/blob/master/dev-setup/coding/git-tldr.md
