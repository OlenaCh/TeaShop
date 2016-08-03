Swagger::Docs::Config.base_api_controller = ActionController::API

Swagger::Docs::Config.register_apis('1.0' => {
    controller_base_path: 'api/v1',
    api_file_path: 'public/api/v1/',
    clean_directory: true,
    base_path: 'http://localhost:3000',
    camelize_model_properties: false,
    base_api_controller: ApplicationController
})