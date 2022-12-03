<?php

namespace App\Http;

use Illuminate\Foundation\Http\Kernel as HttpKernel;

class Kernel extends HttpKernel
{
    /**
     * Глобальные HTTP посредники.
     *
     * Эти посредники запускаются на каждый запрос в приложение.
     *
     * @var array<int, class-string|string>
     */
    protected $middleware = [
        \Illuminate\Http\Middleware\HandleCors::class,
        \Illuminate\Foundation\Http\Middleware\ValidatePostSize::class,
        \App\Http\Middleware\TrimStrings::class,
        \Illuminate\Foundation\Http\Middleware\ConvertEmptyStringsToNull::class,
    ];

    /**
     * Группы посредников.
     *
     * @var array<string, array<int, class-string|string>>
     */
    protected $middlewareGroups = [
        'api' => [
            \Illuminate\Routing\Middleware\SubstituteBindings::class,
        ],
    ];

    /**
     * Посредники маршрутов.
     *
     * @var array<string, class-string|string>
     */
    protected $routeMiddleware = [];
}
