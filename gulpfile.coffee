gulp = require("gulp")

pug = require("gulp-pug")
sass = require("gulp-sass")(require("sass"))
coffee = require("gulp-coffee")

uglify = require("gulp-uglify-es").default

browserSync = require("browser-sync").create()

compilePug = () =>
  return gulp.src("./*.pug")
    .pipe(pug())
    .pipe(gulp.dest("./docs/"))
    .pipe(browserSync.stream())

compileSass = () =>
  return gulp.src("./sass/*.{scss,sass}")
    .pipe(sass({outputStyle: "compressed"}).on("error", sass.logError))
    .pipe(gulp.dest("./docs/assets/styles/"))
    .pipe(browserSync.stream())

compileCoffee = () =>
  return gulp.src("./coffee/*.coffee")
    .pipe(coffee({bare: true}))
    .pipe(uglify())
    .pipe(gulp.dest("./docs/assets/scripts/"))
    .pipe(browserSync.stream())

moveAssets = () =>
  return gulp.src("./assets/**/*")
    .pipe(gulp.dest("./docs/assets/"))

watchTask = () =>
  gulp.watch("./**/*.pug", gulp.series(compilePug, serverReload))
  gulp.watch("./sass/*.sass", gulp.series(compileSass, serverReload))
  gulp.watch("./coffee/*.coffee", gulp.series(compileCoffee, serverReload))
  gulp.watch("./docs/**/*", serverReload)

liveServer = (cb) =>
  browserSync.init({
    server: {
      baseDir: "./docs/"
    }
  })

  cb()

serverReload = (cb) =>
  browserSync.reload()
  cb()

exports.default = gulp.series(
  compilePug,
  compileSass,
  compileCoffee,
  liveServer,
  moveAssets,
  watchTask
)