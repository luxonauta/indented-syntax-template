const gulp = require("gulp")
const coffee = require("gulp-coffee")
const pug = require("gulp-pug")
const sass = require("gulp-sass")(require("sass"))
const uglify = require("gulp-uglify-es").default

exports.default = () => {
    gulp.watch("./coffee/*.coffee", () => {
        return gulp.src("./coffee/*.coffee")
            .pipe(coffee({ bare: true }))
            .pipe(uglify())
            .pipe(gulp.dest("./docs/assets/scripts/"));
    })

    gulp.watch("./sass/*.sass", () => {
        return gulp.src("./sass/*.sass")
            .pipe(sass({ outputStyle: "compressed" }).on("error", sass.logError))
            .pipe(gulp.dest("./docs/assets/styles/"));
    })

    gulp.watch("./**/*.pug", () => {
        return gulp.src("./*.pug")
            .pipe(pug())
            .pipe(gulp.dest("./docs/"));
    })
}