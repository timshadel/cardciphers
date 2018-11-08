var exports = module.exports;
var array = [36, 44, 15, 26, 21, 8, 11, 1, 11, 11, 37, 18, 26, 12, 34, 13, 29, 19, 25, 25, 16, 4, 19, 20, 36, 44, 45, 34, 45, 13, 10, 31, 45, 39, 15, 4, 48, 21, 14, 22, 13, 43, 30, 25, 29, 49, 34, 17, 51, 21, 21, 32, 38, 2, 47, 48, 1, 18, 5, 14, 30, 50, 20, 22, 12, 17, 21, 7, 10, 34, 11, 9, 47, 22, 19, 35, 50, 37, 29, 28, 36, 15, 30, 51, 20, 32, 23, 3, 50, 42, 28, 49, 21, 5, 6, 10, 11, 17, 10, 24, 42, 49, 11, 3, 29, 19, 8, 35, 20, 13, 15, 38, 34, 50, 38, 16, 24, 22, 23, 27, 36, 32, 3, 21, 11, 4, 49, 1, 41, 6, 46, 3, 47, 41, 21, 44, 1, 13, 11, 42, 8, 47, 20, 43, 3, 11, 26, 51, 17, 49, 35, 48, 8, 35, 12, 50, 13, 23, 35, 1, 18, 1, 38, 21, 11, 0, 3, 49, 51, 19, 4, 40, 0, 13, 22, 26, 14, 10, 18, 43, 35, 13, 0, 51, 33, 13, 4, 9, 51, 36, 10, 7, 29, 43, 41, 7, 28, 18, 17, 9, 2, 51, 39, 34, 13, 12, 0, 32, 14, 12, 13, 45, 42, 5, 25, 21, 50, 34, 33, 25, 14, 6, 4, 6, 46, 28, 1, 40, 42, 27, 5, 40, 48, 36, 26, 17, 47, 22, 21, 47, 51, 20, 29, 2, 11, 27, 1, 22, 39, 33, 46, 19, 25, 38, 23, 11, 37, 1, 44, 1, 28, 24, 38, 48, 7, 17, 21, 22, 31, 32, 30, 33, 50, 50, 40, 45, 49, 6, 4, 20, 3, 25, 44, 30, 31, 0, 4, 41, 48, 36, 27, 18, 49, 14, 44, 35, 26, 23, 46, 39, 19, 4, 48, 12, 28, 25, 11, 30, 2, 16, 5, 5, 2, 48, 16, 21, 20, 42, 37, 48, 41, 26, 37, 11, 34, 28, 10, 28, 5, 44, 3, 51, 28, 3, 31, 6, 11, 24, 42, 10, 42, 34, 3, 32, 8, 41, 13, 23, 13, 29, 12, 49, 6, 1, 49, 12, 18, 27, 2, 20, 40, 44, 2, 18, 15, 17, 47, 14, 10, 27, 1, 14, 26, 44, 2, 45, 34, 9, 43, 16, 44, 6, 12, 47, 25, 21, 22, 34, 11, 41, 3, 51, 38, 34, 20, 28, 19, 36, 38, 50, 8, 23, 23, 44, 15, 5, 2, 49, 43, 37, 6, 51, 38, 14, 12, 46, 46, 49, 4, 4, 33, 0, 25, 21, 9, 43, 22, 11, 22, 21, 7, 22, 37, 18, 38, 20, 33, 38, 27, 36, 31, 3, 31, 43, 7, 6, 22, 27, 2, 8, 15, 47, 41, 19, 43, 13, 43, 38, 17, 9, 22, 43, 15, 45, 37, 20, 28, 41, 50, 51, 49, 5, 34, 43, 33, 37, 7, 47, 30, 4, 42, 1, 10, 27, 42, 3, 11, 41, 37, 8, 47, 33, 10, 45, 31, 37, 19, 16, 36, 34, 36, 26, 21, 14, 43, 5, 8, 28, 13, 21, 16, 17, 48, 15, 17, 45, 22, 28, 19, 18, 24, 17, 28, 18, 46, 49, 37, 43, 51, 8, 39, 5, 23, 23, 40, 37, 25, 41, 20, 33, 17, 13, 1, 45, 50, 29, 7, 35, 8, 15, 28, 35, 15, 15, 11, 43, 33, 47, 41, 51, 9, 39, 16, 13, 9, 34, 7, 38, 41, 17, 25, 34, 26, 45, 30, 31, 32, 20, 46, 8, 4, 7, 29, 47, 40, 33, 11, 20, 43, 5, 34, 4, 18, 51, 4, 2, 8, 4, 4, 1, 0, 13, 26, 12, 48, 1, 22, 35, 38, 47, 11, 31, 50, 42, 48, 21, 20, 51, 9, 47, 13, 33, 7, 40, 18, 42, 7, 38, 39, 22, 24, 30, 21, 2, 10, 29, 25, 41, 46, 39, 1, 41, 20, 42, 11, 17, 12, 17, 33, 18, 7, 31, 6, 2, 30, 48, 24, 17, 6, 51, 35, 0, 8, 19, 20, 13, 38, 40, 11, 23, 41, 34, 16, 17, 21, 31, 6, 47, 12, 23, 20, 9, 31, 34, 20, 41, 33, 44, 16, 42, 49, 29, 47, 37, 39, 47, 15, 46, 30, 40, 36, 8, 27, 20, 42, 31, 26, 7, 50, 21, 30, 40, 49, 34, 37, 6, 32, 36, 51, 46, 4, 15, 19, 35, 17, 4, 42, 51, 34, 33, 45, 14, 39, 5, 39, 36, 29, 14, 38, 25, 11, 1, 50, 10, 39, 36, 0, 17, 44, 41, 31, 37, 45, 44, 6, 7, 4, 34, 47, 49, 47, 12, 25, 9, 22, 32, 13, 6, 42, 41, 25, 6, 1, 44, 20, 36, 34, 49, 8, 21, 23, 38, 33, 48, 39, 32, 9, 35, 42, 2, 42, 6, 47, 5, 40, 1, 48, 24, 47, 6, 28, 45, 27, 29, 37, 9, 0, 39, 15, 4, 16, 46, 23, 50, 13, 14, 7, 47, 33, 31, 43, 3, 6, 27, 51, 35, 20, 50, 24, 18, 2, 49, 47, 12, 5, 40, 42, 35, 6, 11, 11, 24, 32, 6, 19, 35, 35, 17, 6, 10, 19, 32, 3, 10, 10, 18, 36, 33, 18, 23, 29, 33, 24, 1, 26, 7, 16, 33, 4, 43, 47, 49, 15, 17, 37, 14, 1, 45, 9, 37, 8, 18, 9, 39, 27, 24, 36, 39, 19, 30, 6, 35, 36, 20, 50, 45, 1, 5, 45, 35, 34, 12, 47, 48, 51, 26, 30, 4, 33, 44, 13, 27, 16, 35, 50, 43, 51, 22, 11, 27, 29, 18, 13, 16, 27, 37, 0, 42, 44, 22, 22, 43, 40, 41, 38, 8, 3, 48, 24, 11, 24, 29, 5, 49, 23, 3, 15, 35, 43, 11, 4, 17, 18, 50, 36, 19, 6, 11, 48, 10, 10, 36, 17, 21, 22, 14, 4, 37, 11, 17, 46, 8, 3, 13, 25, 16, 51, 10, 21, 37, 34, 35, 46, 6, 27, 11, 3, 37, 5, 45, 14, 20, 41, 9, 5, 42, 38, 26, 29, 26, 48, 16, 13, 47, 7, 2, 51, 51, 47, 9, 15, 6, 46, 7, 37, 33, 3, 26, 37, 51, 39, 49, 34, 14, 22, 26, 13, 41, 18, 5, 16, 35, 49, 31, 48, 39, 34, 37, 25, 47, 1, 51, 38, 14, 22, 49, 6, 29, 29, 9, 3, 28, 6, 6, 49, 31, 36, 20, 21, 42, 1, 31, 32, 37, 18, 39, 12, 15, 18, 29, 46, 4, 6, 33, 3, 50, 49, 36, 26, 9, 40, 42, 2, 33, 47, 32, 25, 40, 44, 48, 20, 15, 44, 22, 41, 14, 45, 27, 25, 47, 21, 29, 25, 45, 13, 7, 25, 48, 16, 7, 7, 39, 26, 12, 17, 33, 41, 26, 14, 15, 16, 16, 17, 5, 16, 41, 33, 1, 34, 51, 37, 19, 11, 8, 14, 19, 50, 38, 32, 17, 38, 40, 48, 5, 31, 28, 38, 3, 24, 19];
exports.array = array;
