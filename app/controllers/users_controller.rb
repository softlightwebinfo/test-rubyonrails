class UsersController < ApplicationController
  @root_url = "users/index"
  layout 'application'
  add_flash_types :notice

  # Listar todos los registros de la Base de Datos
  def index
    @users = User.all()
  end

  # Leer los detalles de un registro
  def read
    @user = params[:id]
    @user = User.where(id: @user)
  end

  # Llamamos a la vista con el formulario para crear un registro
  def create
    @user = User.new
  end

  # Procesamos la creación de un registro en la base de datos
  def insertar

    # Subimos el Archivo al servidor
    uploaded_file = params[:img]
    File.open(Rails.root.join('public', 'assets/img', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end
    @user = User.new(parametros)


    # Insertamos un registro en la base de datos
    if @user.save

      @user.update_column(:img, uploaded_file.original_filename)

    else
      render :new
    end

    # Redireccionamos a la vista principal con mensaje
    @ini = "/users/index"
    flash[:notice] = "Creado Correctamente !"
    redirect_to @ini
  end

  # Llamamos a la vista con el formulario para actualizar un registro
  def update
    # Pasamos el 'id' del registro a actualizar (método index)
    @user = User.find(params[:id])
    @user = User.where(id: @user)
  end

  # Procesamos la actualización de un registro en la base de datos
  def editar

    # Pasamos el 'id' del registro a actualizar (método editar)
    @user = User.find(params[:id])

    # Actualizamos el Archivo al servidor
    uploaded_file = params[:img]

    if params[:img].present?

      # Eliminamos el archivo (imagen) anterior
      simg = User.where(:id => @user).pluck(:img)
      imgeliminar = Rails.root.join('public', 'assets/img', simg.join)
      File.delete(Rails.root + imgeliminar)

      # Subimos el nuevo archivo (imagen)
      File.open(Rails.root.join('public', 'assets/img', uploaded_file.original_filename), 'wb') do |file|
        file.write(uploaded_file.read)
      end

    else
      #
    end

    # Actualizamos un determinado registro en la base de datos
    if @user.update(parametros)

      # Actualizamos la columna 'img' de la base de datos
      if params[:img].present?
        @user.update_column(:img, uploaded_file.original_filename)
      else
        #
      end

    else
      render :edit
    end

    # Redireccionamos a la vista principal con mensaje
    @ini = "/users/index"
    flash[:notice] = "Actualizado Correctamente !"
    redirect_to @ini

  end

  # Procesamos la eliminación de un registro de la base de datos
  def eliminar

    # Eliminamos un determinado registro en la base de datos, pasamos el 'id' del registro a eliminar
    @user = User.find(params[:id])

    # Eliminamos la imagen perteneciente al registro
    simg = User.where(:id => @user).pluck(:img)
    imgeliminar = Rails.root.join('public', 'assets/img', simg.join)
    File.delete(Rails.root + imgeliminar)

    User.where(id: @user).destroy_all

    # Redireccionamos a la vista principal con mensaje
    @ini = "/users/index"
    flash[:notice] = "Eliminado Correctamente !"
    redirect_to @ini
  end

  # Parámetros o campos que insertamos o actualizamos en la base de datos

  private

  def parametros
    params.permit(:name, :email, :phone, :img, :created_at, :password)
  end
end
