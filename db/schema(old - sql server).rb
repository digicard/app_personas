# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "dc_taContratos", primary_key: "ContratoID", id: :integer, force: :cascade do |t|
    t.integer "EmpresaID", null: false
    t.integer "ProductoID", null: false
    t.datetime "VigenciaD", null: false
    t.datetime "VigenciaH", null: false
    t.integer "CantLicencias", null: false
    t.string "URL", limit: 512
    t.string "DB", limit: 512
    t.string "Dominio", limit: 512
    t.string "OTI", limit: 32
    t.string "CrmLink", limit: 256
    t.varchar "DBServidor", limit: 256
    t.integer "DBPuerto"
    t.varchar "DBUsuario", limit: 128
    t.varchar "DBPass", limit: 128
  end

  create_table "dc_taContratosUsuarios", primary_key: "ContUsrID", id: :integer, force: :cascade do |t|
    t.integer "UsuarioID", null: false
    t.integer "ContratoID", null: false
  end

  create_table "dc_taEmpresas", primary_key: "EmpresaID", id: :integer, force: :cascade do |t|
    t.string "CUIT", limit: 15, null: false
    t.string "Nombre", limit: 128, null: false
    t.string "Descripcion", limit: 256
    t.boolean "Habilitada", null: false
  end

  create_table "dc_taMovimLog", primary_key: "MovimId", force: :cascade do |t|
    t.datetime "Fecha", null: false
    t.integer "UsuarioId", null: false
    t.char "Accion", limit: 1, null: false
    t.integer "ProductoID"
  end

  create_table "dc_taPerfiles", primary_key: "PerfilID", id: :integer, force: :cascade do |t|
    t.string "Nombre", limit: 128, null: false
    t.string "Descripcion", limit: 256
    t.boolean "Habilitado", null: false
  end

  create_table "dc_taPersonas", primary_key: "PersonaID", force: :cascade do |t|
    t.string "Apellido", limit: 128, null: false
    t.string "Nombre", limit: 128, null: false
    t.string "TDoc", limit: 16, null: false
    t.string "NDoc", limit: 32, null: false
    t.boolean "Habil", null: false
    t.binary "Foto"
    t.string "CUIL", limit: 15
  end

  create_table "dc_taProductos", primary_key: "ProductoID", id: :integer, force: :cascade do |t|
    t.string "Nombre", limit: 128, null: false
    t.string "Descripcion", limit: 256
    t.boolean "Habilitado", null: false
    t.string "Logo", limit: 256
  end

  create_table "dc_taUsuarios", primary_key: "UsuarioID", id: :integer, force: :cascade do |t|
    t.string "UniqueName", limit: 256, null: false
    t.nchar "HashPass", limit: 48, null: false
    t.integer "EmpresaID", null: false
    t.integer "PerfilID", null: false
    t.boolean "Habilitado", null: false
    t.boolean "ForzarCambioPass", null: false
    t.bigint "PersonaID"
    t.string "ContactoTelef", limit: 64
    t.string "ContactoMail", limit: 128
    t.char "Idioma", limit: 2, null: false
    t.index ["UniqueName"], name: "UQ_dc_taUsuarios", unique: true
  end

  create_table "dca_taAreas", primary_key: "AreaID", force: :cascade do |t|
    t.varchar "Nombre", limit: 64, null: false
    t.varchar "Descripcion", limit: 128, null: false
    t.integer "EmpresaID", null: false
  end

  create_table "dca_taCategs", primary_key: "CategID", force: :cascade do |t|
    t.varchar "Nombre", limit: 30, null: false
    t.varchar "Descripcion", limit: 50
    t.integer "EmpresaID", null: false
  end

  create_table "dca_taConfig", primary_key: "CfgID", id: :integer, force: :cascade do |t|
    t.varchar "CfgNombre", limit: 64, null: false
    t.varchar "Comentario", limit: 256
    t.varchar "ValorDef", limit: 64, null: false
    t.varchar "ValorCorr", limit: 64, null: false
    t.integer "EmpresaID"
  end

  create_table "dca_taDfis", primary_key: "DfiID", force: :cascade do |t|
    t.bigint "PcaID", null: false
    t.varchar "Nombre", limit: 64, null: false
    t.varchar "Alias", limit: 32
    t.varchar "Descripcion", limit: 128
    t.integer "TipoHard", null: false
    t.integer "ReqPassBack", null: false
    t.integer "ReqPin", null: false
    t.integer "ReqCacheo", null: false
    t.integer "PorcenCacheo", null: false
    t.bigint "AreaIDOri", null: false
    t.bigint "AreaIDDest", null: false
  end

  create_table "dca_taEventos", primary_key: "EventoID", force: :cascade do |t|
    t.varchar "Evento", limit: 16, null: false
    t.varchar "Descripcion", limit: 128
    t.char "Accion", limit: 1, null: false
    t.boolean "DefUsuario", null: false
    t.char "Fuente", limit: 3, null: false
    t.boolean "Alarma", null: false
    t.integer "AlrTpoReco", null: false
    t.bigint "AlrMensajeID"
    t.integer "EmpresaID", null: false
  end

  create_table "dca_taGrupos", primary_key: "GrupoID", force: :cascade do |t|
    t.bigint "GrupoPadreID"
    t.varchar "Nombre", limit: 30, null: false
    t.varchar "Descripcion", limit: 50
    t.integer "EmpresaID", null: false
  end

  create_table "dca_taMensajes", primary_key: "MensajeID", force: :cascade do |t|
    t.varchar "Nombre", limit: 64, null: false
    t.varchar "Texto", limit: 1024, null: false
    t.integer "EmpresaID", null: false
  end

  create_table "dca_taModelosPaneles", primary_key: "ModeloPanelID", id: :integer, force: :cascade do |t|
    t.varchar "Nombre", limit: 64, null: false
    t.varchar "Descripcion", limit: 256
    t.varchar "Controlador", limit: 256, null: false
  end

  create_table "dca_taMovim", primary_key: "MovimId", force: :cascade do |t|
    t.datetime "Fecha", null: false
    t.bigint "EventoId"
    t.bigint "DfiId"
    t.varchar "Args", limit: 128
    t.bigint "PersonaCaID"
    t.integer "EmpresaID", null: false
  end

  create_table "dca_taPaneles", primary_key: "PanelID", force: :cascade do |t|
    t.varchar "Nombre", limit: 48, null: false
    t.varchar "Direccion", limit: 128, null: false
    t.integer "ModeloPanelID", null: false
    t.boolean "Activo", null: false
    t.integer "EmpresaID", null: false
  end

  create_table "dca_taPcas", primary_key: "PcaID", force: :cascade do |t|
    t.varchar "Nombre", limit: 64, null: false
    t.varchar "Descripcion", limit: 128
    t.text_basic "Script"
    t.boolean "Activo", null: false
    t.bigint "PanelID", null: false
    t.datetime "FecUltUpd", null: false
  end

  create_table "dca_taPermisos", primary_key: "PermisoID", force: :cascade do |t|
    t.varchar "Nombre", limit: 64, null: false
    t.varchar "Descripcion", limit: 128
    t.boolean "Activo", null: false
    t.integer "EmpresaID", null: false
  end

  create_table "dca_taPermisosD", primary_key: ["PermisoID", "DiaSemFer", "Desde", "DfiID"], force: :cascade do |t|
    t.bigint "PermisoID", null: false
    t.char "DiaSemFer", limit: 2, null: false
    t.integer "Desde", null: false
    t.integer "Hasta", null: false
    t.bigint "DfiID", null: false
  end

  create_table "dca_taPersonasCa", primary_key: "PersonaCaID", force: :cascade do |t|
    t.datetime "FecAlta", null: false
    t.datetime "FecBaja"
    t.boolean "Habil", null: false
    t.string "Contacto", limit: 512
    t.bigint "CategID", null: false
    t.bigint "PersonaID", null: false
    t.integer "EmpresaID", null: false
    t.bigint "UltMovimID"
  end

  create_table "dca_taPersonasCaGrupos", primary_key: ["PersonaCaID", "GrupoID", "FecDesde"], force: :cascade do |t|
    t.bigint "PersonaCaID", null: false
    t.bigint "GrupoID", null: false
    t.datetime "FecDesde", null: false
    t.datetime "FecHasta"
  end

  create_table "dca_taPersonasCaPermisos", primary_key: ["PersonaCaID", "PermisoID", "FecDesde"], force: :cascade do |t|
    t.bigint "PersonaCaID", null: false
    t.bigint "PermisoID", null: false
    t.datetime "FecDesde", null: false
    t.datetime "FecHasta"
  end

  create_table "dca_taPersonasCaTarjetas", primary_key: ["PersonaCaID", "TarjID", "FecDesde"], force: :cascade do |t|
    t.bigint "PersonaCaID", null: false
    t.bigint "TarjID", null: false
    t.datetime "FecDesde", null: false
    t.datetime "FecHasta"
  end

  create_table "dca_taTarjetas", primary_key: "TarjID", force: :cascade do |t|
    t.string "Tarjeta", limit: 32, null: false
    t.boolean "Habil", null: false
    t.integer "EmpresaID", null: false
    t.index ["EmpresaID", "Tarjeta"], name: "UQ_dca_taTarjetas", unique: true
  end

  create_table "dvi_taApiDca", primary_key: ["EmpresaID", "Servicio"], force: :cascade do |t|
    t.integer "EmpresaID", null: false
    t.char "Servicio", limit: 4, null: false
    t.datetime "FecUltAct", null: false
  end

  create_table "dvi_taApiDcaLogs", primary_key: "ProcID", force: :cascade do |t|
    t.datetime "FecUltAct", null: false
    t.char "Servicio", limit: 4, null: false
    t.string "Mensaje", limit: 1024
    t.datetime "RqIni", null: false
    t.datetime "RqFin", null: false
    t.integer "ErrorID", null: false
    t.integer "EmpresaID", null: false
  end

  create_table "dvi_taAsegurables", primary_key: "AsegID", id: :integer, force: :cascade do |t|
    t.integer "AsegPadreID"
    t.string "Clave", limit: 256, null: false
    t.string "Nombre", limit: 128, null: false
    t.string "Descripcion", limit: 512, null: false
    t.integer "Nivel", null: false
    t.integer "Orden", null: false
    t.integer "PerfilID", null: false
    t.index ["Clave"], name: "UQ_dvi_taAsegurables_Clave", unique: true
  end

  create_table "dvi_taCategs", primary_key: "CategID", force: :cascade do |t|
    t.varchar "Nombre", limit: 30, null: false
    t.varchar "Descrip", limit: 50
    t.boolean "Observada", null: false
    t.integer "DuracionTarjeta", null: false
    t.boolean "PermiteESinter", null: false
    t.integer "EmpresaID", null: false
    t.index ["EmpresaID"], name: "IX_dvi_taCategs"
  end

  create_table "dvi_taCitas", primary_key: "CitaID", force: :cascade do |t|
    t.string "Asunto", limit: 64
    t.string "Comentario", limit: 512
    t.datetime "FechaSolicitud"
    t.datetime "FechaAtSolic"
    t.datetime "FechaCita", null: false
    t.integer "Antelacion", null: false
    t.integer "Tolerancia", null: false
    t.bigint "AreaID"
    t.bigint "VteID", null: false
    t.bigint "VdoID", null: false
    t.bigint "MotivoID", null: false
    t.integer "EmpresaID", null: false
    t.string "Estado", limit: 10, null: false
    t.boolean "AprobadoVdo", null: false
    t.boolean "AprobadoVte", null: false
  end

  create_table "dvi_taCitasNotas", primary_key: ["CitaID", "NotaID"], force: :cascade do |t|
    t.bigint "CitaID", null: false
    t.integer "NotaID", null: false
    t.string "Titulo", limit: 128, null: false
    t.text "Texto"
    t.string "Adjunto"
    t.bigint "MotivoID"
  end

  create_table "dvi_taEmpres", primary_key: "EmpreID", force: :cascade do |t|
    t.varchar "Nombre", limit: 30, null: false
    t.varchar "Descrip", limit: 50
    t.integer "EmpresaID", null: false
    t.varchar "Direccion", limit: 128
    t.varchar "Localidad", limit: 50
    t.varchar "Provincia", limit: 50
    t.varchar "Pais", limit: 64
    t.varchar "CodPos", limit: 16
    t.varchar "Tel", limit: 64
    t.varchar "Contacto", limit: 64
    t.varchar "CUIT", limit: 32
    t.boolean "Habil", null: false
    t.index ["EmpresaID"], name: "IX_dvi_taEmpres"
  end

  create_table "dvi_taMotivos", primary_key: "MotivoID", force: :cascade do |t|
    t.varchar "Nombre", limit: 32, null: false
    t.varchar "Descripcion", limit: 50
    t.integer "EmpresaID", null: false
    t.index ["EmpresaID"], name: "IX_dvi_taMotivos"
  end

  create_table "dvi_taMovimContadores", primary_key: ["EmpresaID", "Fecha"], force: :cascade do |t|
    t.integer "EmpresaID", null: false
    t.date "Fecha", null: false
    t.integer "Cantidad", null: false
  end

  create_table "dvi_taMovimVis", primary_key: "MovimID", force: :cascade do |t|
    t.bigint "VteID", null: false
    t.datetime "FecIngreso", null: false
    t.datetime "FecEgreso"
    t.bigint "VdoID", null: false
    t.bigint "AutorizVdoID"
    t.bigint "MotivoID"
    t.integer "UsrIngID", null: false
    t.integer "UsrEgrID"
    t.bigint "CitaID"
    t.char "Estado", limit: 2, null: false
    t.integer "TarjId"
    t.integer "DcaPermisoId"
    t.bigint "EmpresaID", null: false
    t.bigint "AreaID"
    t.bigint "HorarioID"
    t.char "DiaSemFer", limit: 2
    t.bigint "CategID"
    t.bigint "EmpreID"
    t.index ["EmpresaID"], name: "IX_dvi_taMovimVis"
  end

  create_table "dvi_taMovimVisComentarios", primary_key: ["MovimID", "ComentarioID"], force: :cascade do |t|
    t.bigint "MovimID", null: false
    t.integer "ComentarioID", null: false
    t.integer "Sentido", null: false
    t.string "Comentario", limit: 1024
  end

  create_table "dvi_taMovimVisEspera", primary_key: "MovimEsperaID", force: :cascade do |t|
    t.bigint "VteID", null: false
    t.datetime "FechaInicio", null: false
    t.datetime "FechaFin"
    t.bigint "VdoID", null: false
    t.varchar "Estado", limit: 10, null: false
    t.bigint "EmpresaID", null: false
    t.bigint "AutorizVdoID"
  end

  create_table "dvi_taMovimVisPert", primary_key: ["MovimID", "PertenenciaID"], force: :cascade do |t|
    t.bigint "MovimID", null: false
    t.bigint "PertenenciaID", null: false
  end

  create_table "dvi_taPertenencias", primary_key: "PertenenciaID", force: :cascade do |t|
    t.string "Nombre", limit: 64, null: false
    t.string "Descrip", limit: 512
    t.string "Codigo", limit: 32
    t.bigint "VteID", null: false
  end

  create_table "dvi_taPoliticas", primary_key: "PoliticaID", force: :cascade do |t|
    t.string "Nombre", limit: 64, null: false
    t.string "Descripcion", limit: 512
    t.integer "EmpresaID", null: false
    t.index ["EmpresaID"], name: "IX_dvi_taPoliticas"
  end

  create_table "dvi_taPrivilegios", primary_key: ["RolID", "AsegID"], force: :cascade do |t|
    t.integer "RolID", null: false
    t.integer "AsegID", null: false
  end

  create_table "dvi_taRoles", primary_key: "RolID", id: :integer, force: :cascade do |t|
    t.string "Nombre", limit: 64, null: false
    t.string "Descripcion", limit: 512
    t.integer "EmpresaID", null: false
    t.boolean "Admin", null: false
    t.index ["EmpresaID", "Nombre"], name: "UQ_dvi_taRoles_Nombre", unique: true
    t.index ["EmpresaID"], name: "IX_dvi_taRoles"
  end

  create_table "dvi_taRolesUsuarios", primary_key: ["RolID", "UsuarioID"], force: :cascade do |t|
    t.integer "RolID", null: false
    t.integer "UsuarioID", null: false
  end

  create_table "dvi_taSolicitudesAsoc", primary_key: "SolicitudAsocID", force: :cascade do |t|
    t.datetime "Fecha", null: false
    t.integer "UsuarioID", null: false
    t.integer "EmpresaID", null: false
    t.string "Estado", limit: 10, null: false
  end

  create_table "dvi_taSolicitudesUsr", primary_key: "SolicitudUsrID", force: :cascade do |t|
    t.datetime "Fecha", null: false
    t.string "Apellido", limit: 128, null: false
    t.string "Nombre", limit: 128, null: false
    t.string "TDoc", limit: 16, null: false
    t.string "NDoc", limit: 32, null: false
    t.string "CUIL", limit: 15
    t.string "Mail", limit: 128, null: false
    t.string "PalabraClave", limit: 32, null: false
    t.string "Tel", limit: 32
    t.string "Estado", limit: 10, null: false
    t.binary "Foto"
  end

  create_table "dvi_taTarjetas", primary_key: "TarjID", force: :cascade do |t|
    t.string "Tarjeta", limit: 32, null: false
    t.boolean "Habilitada", null: false
    t.boolean "EnUso", null: false
    t.integer "EmpresaID", null: false
    t.index ["EmpresaID", "Tarjeta"], name: "UQ_dvi_taTarjetas", unique: true
    t.index ["EmpresaID"], name: "IX_dvi_taTarjetas"
  end

  create_table "dvi_taVdos", primary_key: "VdoID", force: :cascade do |t|
    t.bigint "PersonaID", null: false
    t.integer "EmpresaID", null: false
    t.bigint "AreaID", null: false
    t.datetime "FecAlta", null: false
    t.datetime "FecBaja"
    t.boolean "Habil", null: false
    t.boolean "EnArea"
    t.boolean "VisibleCitas", null: false
    t.varchar "Contacto", limit: 512
    t.index ["EmpresaID"], name: "IX_dvi_taVdos"
  end

  create_table "dvi_taVisAreas", primary_key: "AreaID", force: :cascade do |t|
    t.integer "EmpresaID", null: false
    t.varchar "Nombre", limit: 64, null: false
    t.varchar "Descripcion", limit: 256
    t.boolean "Habilitada", null: false
    t.integer "MaxVtes", null: false
    t.integer "MaxTiPermVtes", null: false
    t.integer "CantVtes", null: false
    t.index ["EmpresaID"], name: "IX_dvi_taVisAreas"
  end

  create_table "dvi_taVisAreasHorarios", primary_key: ["AreaID", "HorarioID"], force: :cascade do |t|
    t.bigint "AreaID", null: false
    t.bigint "HorarioID", null: false
  end

  create_table "dvi_taVisHorarios", primary_key: "HorarioID", force: :cascade do |t|
    t.integer "EmpresaID", null: false
    t.varchar "Nombre", limit: 64, null: false
    t.varchar "Descripcion", limit: 256
    t.integer "MaxTiPermVtes", null: false
    t.index ["EmpresaID"], name: "IX_dvi_taVisHorarios"
  end

  create_table "dvi_taVisHorariosD", primary_key: ["HorarioID", "DiaSemFer"], force: :cascade do |t|
    t.bigint "HorarioID", null: false
    t.char "DiaSemFer", limit: 2, null: false
    t.integer "Desde", null: false
    t.integer "Hasta", null: false
    t.integer "Orden", null: false
    t.integer "MaxVtes", null: false
    t.integer "CantVtes", null: false
  end

  create_table "dvi_taVtes", primary_key: "VteID", force: :cascade do |t|
    t.bigint "PersonaID", null: false
    t.integer "EmpresaID", null: false
    t.datetime "FecAlta", null: false
    t.datetime "FecBaja"
    t.boolean "Habil", null: false
    t.integer "CantMovimVis"
    t.bigint "UltMovimID"
    t.bigint "CategID", null: false
    t.bigint "EmpreID", null: false
    t.string "Mail", limit: 256
    t.index ["EmpresaID"], name: "IX_dvi_taVtes"
  end

  create_table "rcp_taAcciones", primary_key: "AccionID", id: :integer, force: :cascade do |t|
    t.string "Nombre", limit: 32, null: false
    t.string "Descripcion", limit: 128
    t.char "Codigo", limit: 2, null: false
    t.boolean "PermiteEjecManual", null: false
    t.boolean "PermiteEjecAuto", null: false
  end

  create_table "rcp_taAsegurables", primary_key: "AsegID", id: :integer, force: :cascade do |t|
    t.integer "AsegPadreID"
    t.string "Clave", limit: 256, null: false
    t.string "Nombre", limit: 32, null: false
    t.string "Descripcion", limit: 512, null: false
    t.integer "Nivel", null: false
    t.integer "Orden", null: false
    t.index ["Clave"], name: "UQ_rcp_taAsegurables_Clave", unique: true
  end

  create_table "rcp_taBioFormatos", primary_key: "FmtID", id: :integer, force: :cascade do |t|
    t.string "Nombre", limit: 32, null: false
    t.string "Descripcion", limit: 64, null: false
    t.index ["Nombre"], name: "UQ_rcp_taBioFormatos_Nom", unique: true
  end

  create_table "rcp_taDeviceServices", primary_key: "DeviceServiceID", id: :integer, force: :cascade do |t|
    t.string "Nombre", limit: 64, null: false
    t.string "Descripcion", limit: 256
    t.string "Identificacion", limit: 64, null: false
    t.boolean "Habilitado", null: false
    t.integer "HusoHorario", null: false
    t.integer "EmpresaID", null: false
    t.index ["Identificacion"], name: "UQ_rcp_taDeviceServices", unique: true
  end

  create_table "rcp_taEmpresasUsuarios", primary_key: ["EmpresaID", "UsuarioID"], force: :cascade do |t|
    t.integer "EmpresaID", null: false
    t.integer "UsuarioID", null: false
  end

  create_table "rcp_taHorarios", primary_key: "HorarioID", id: :integer, force: :cascade do |t|
    t.integer "PlanID", null: false
    t.string "Frecuencia", limit: 32, null: false
    t.string "DiasSem", limit: 32, null: false
    t.integer "RepetirCada"
    t.integer "UtcHoraInicio", null: false
    t.integer "UtcHoraFin"
  end

  create_table "rcp_taLogEjecuciones", primary_key: ["DeviceServiceID", "FechaCreacion", "MsgId"], force: :cascade do |t|
    t.integer "DeviceServiceID", null: false
    t.date "FechaCreacion", null: false
    t.integer "MsgId", null: false
    t.integer "PlanID"
    t.integer "TareaId"
    t.integer "RelojId", null: false
    t.integer "AccionId", null: false
    t.integer "UsuarioId"
    t.datetime "FechaInicio"
    t.datetime "FechaFin"
    t.string "Observaciones", limit: 1024
    t.datetime "FechaUltAct", null: false
    t.varchar "Estado", limit: 16, null: false
  end

  create_table "rcp_taLogEventos", primary_key: "LogEventoID", force: :cascade do |t|
    t.datetime "Fecha", null: false
    t.string "Origen", limit: 128, null: false
    t.integer "UsuarioID", null: false
    t.integer "CodigoError", null: false
    t.varchar "TextoError", limit: 4096
  end

  create_table "rcp_taModelosRelojes", primary_key: "RcpModeloID", id: :integer, force: :cascade do |t|
    t.string "Marca", limit: 32, null: false
    t.string "Modelo", limit: 32, null: false
    t.date "Anio", null: false
    t.string "Descripcion", limit: 256
    t.integer "FmtHuellaID", null: false
    t.integer "FmtFacialID", null: false
    t.string "Imagen"
  end

  create_table "rcp_taModelosRelojesAcciones", primary_key: ["RcpModeloID", "AccionID"], force: :cascade do |t|
    t.integer "RcpModeloID", null: false
    t.integer "AccionID", null: false
  end

  create_table "rcp_taModosAutenticacion", primary_key: "Autenticacion", id: :integer, default: nil, force: :cascade do |t|
    t.string "Codigo", limit: 16, null: false
    t.string "Descripcion", limit: 255
  end

  create_table "rcp_taPlanes", primary_key: "PlanID", id: :integer, force: :cascade do |t|
    t.boolean "Habilitado", null: false
    t.string "Nombre", limit: 64, null: false
    t.string "Descripcion", limit: 256
    t.datetime "VigenciaDesde", null: false
    t.datetime "VigenciaHasta"
    t.integer "EmpresaID", null: false
  end

  create_table "rcp_taPrivilegios", primary_key: ["RolID", "AsegID"], force: :cascade do |t|
    t.integer "RolID", null: false
    t.integer "AsegID", null: false
  end

  create_table "rcp_taRelojes", primary_key: "RelojID", id: :integer, force: :cascade do |t|
    t.string "Nombre", limit: 50, null: false
    t.string "Descripcion", limit: 255
    t.string "DireccionIP", limit: 32
    t.integer "Puerto"
    t.integer "Nodo"
    t.boolean "Habilitado", null: false
    t.integer "DeviceServiceID", null: false
    t.integer "RcpModeloID", null: false
    t.integer "Autenticacion", null: false
    t.datetime "FecUltAct", null: false
    t.integer "RcpIdDta", null: false
    t.integer "SentidoFichadaID", null: false
    t.index ["Nombre"], name: "UQ_rcp_taRelojes_Nom", unique: true
  end

  create_table "rcp_taRelojesSentidoFichada", primary_key: "SentidoFichadaID", id: :integer, force: :cascade do |t|
    t.string "Nombre", limit: 50, null: false
    t.string "Descripcion", limit: 256
    t.integer "Valor"
  end

  create_table "rcp_taRelojesUsuarios", primary_key: "RegID", force: :cascade do |t|
    t.integer "EmpresaID", null: false
    t.integer "RelojID", null: false
    t.integer "UserID", null: false
    t.string "UserName", limit: 128, null: false
    t.datetime "Fecha", null: false
  end

  create_table "rcp_taRelojesUsuariosMinucias", primary_key: ["RegID", "NumID"], force: :cascade do |t|
    t.bigint "RegID", null: false
    t.integer "NumID", null: false
    t.char "Tipo", limit: 2, null: false
    t.varbinary "Minucia", limit: 2048, null: false
  end

  create_table "rcp_taRelojesUsuariosTarjetas", primary_key: ["RegID", "Tarjeta"], force: :cascade do |t|
    t.bigint "RegID", null: false
    t.string "Tarjeta", limit: 40, null: false
  end

  create_table "rcp_taRoles", primary_key: "RolID", id: :integer, force: :cascade do |t|
    t.string "Nombre", limit: 64, null: false
    t.string "Descripcion", limit: 512
    t.boolean "Adminis", null: false
    t.integer "EmpresaID", null: false
    t.index ["EmpresaID", "Nombre"], name: "UQ_rcp_taRoles_Nombre", unique: true
  end

  create_table "rcp_taRolesUsuarios", primary_key: ["RolID", "UsuarioID"], force: :cascade do |t|
    t.integer "RolID", null: false
    t.integer "UsuarioID", null: false
  end

  create_table "rcp_taTareas", primary_key: "TareaID", id: :integer, force: :cascade do |t|
    t.integer "PlanID", null: false
    t.integer "RelojID", null: false
    t.integer "Orden", null: false
    t.string "Descripcion", limit: 256
    t.integer "AccionID", null: false
    t.boolean "Habilitada", null: false
    t.integer "Timeout"
  end

  add_foreign_key "dc_taContratos", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dc_taContratos_dc_taEmpresas"
  add_foreign_key "dc_taContratos", "dc_taProductos", column: "ProductoID", primary_key: "ProductoID", name: "FK_dc_taContratos_dc_taProductos"
  add_foreign_key "dc_taContratosUsuarios", "dc_taContratos", column: "ContratoID", primary_key: "ContratoID", name: "FK_dc_taContratosUsuarios_dc_taContratos"
  add_foreign_key "dc_taContratosUsuarios", "dc_taUsuarios", column: "UsuarioID", primary_key: "UsuarioID", name: "FK_dc_taContratosUsuarios_dc_taUsuarios"
  add_foreign_key "dc_taUsuarios", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dc_taUsuarios_dc_taEmpresas"
  add_foreign_key "dc_taUsuarios", "dc_taPerfiles", column: "PerfilID", primary_key: "PerfilID", name: "FK_dc_taUsuarios_dc_taPerfiles"
  add_foreign_key "dc_taUsuarios", "dc_taPersonas", column: "PersonaID", primary_key: "PersonaID", name: "FK_dc_taUsuarios_dc_taPersonas"
  add_foreign_key "dca_taAreas", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dca_taAreas_dc_taEmpresas"
  add_foreign_key "dca_taCategs", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dca_taCategs_dc_taEmpresas"
  add_foreign_key "dca_taDfis", "dca_taAreas", column: "AreaIDDest", primary_key: "AreaID", name: "FK_dca_taDfis_dca_taAreasD"
  add_foreign_key "dca_taDfis", "dca_taAreas", column: "AreaIDOri", primary_key: "AreaID", name: "FK_dca_taDfis_dca_taAreasO"
  add_foreign_key "dca_taDfis", "dca_taPcas", column: "PcaID", primary_key: "PcaID", name: "FK_dca_taDfis_Pca"
  add_foreign_key "dca_taEventos", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dca_taEventos_dc_taEmpresas"
  add_foreign_key "dca_taEventos", "dca_taMensajes", column: "AlrMensajeID", primary_key: "MensajeID", name: "FK_dca_taEventos_dca_taMensajes"
  add_foreign_key "dca_taGrupos", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dca_taGrupos_dc_taEmpresas"
  add_foreign_key "dca_taPaneles", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dca_taPaneles_dc_taEmpresas"
  add_foreign_key "dca_taPaneles", "dca_taModelosPaneles", column: "ModeloPanelID", primary_key: "ModeloPanelID", name: "FK_dca_taPaneles_Modelo"
  add_foreign_key "dca_taPcas", "dca_taPaneles", column: "PanelID", primary_key: "PanelID", name: "FK_dca_taPcas_dca_taPaneles"
  add_foreign_key "dca_taPermisos", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dca_taPermisos_dc_taEmpresas"
  add_foreign_key "dca_taPermisosD", "dca_taDfis", column: "DfiID", primary_key: "DfiID", name: "FK_dca_taPermisosD_dca_taDfis"
  add_foreign_key "dca_taPermisosD", "dca_taPermisos", column: "PermisoID", primary_key: "PermisoID", name: "FK_dca_taPermisosD_dca_Permisos"
  add_foreign_key "dca_taPersonasCa", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dca_taPersonasCa_dc_taEmpresas"
  add_foreign_key "dca_taPersonasCa", "dc_taPersonas", column: "PersonaID", primary_key: "PersonaID", name: "FK_dca_taPersonasCa_dc_taPersonas"
  add_foreign_key "dca_taPersonasCa", "dca_taCategs", column: "CategID", primary_key: "CategID", name: "FK_dca_taPersonasCa_dca_taCategs"
  add_foreign_key "dca_taPersonasCaGrupos", "dca_taGrupos", column: "GrupoID", primary_key: "GrupoID", name: "FK_dca_taPersCaGrp_dca_taGrupos"
  add_foreign_key "dca_taPersonasCaGrupos", "dca_taPersonasCa", column: "PersonaCaID", primary_key: "PersonaCaID", name: "FK_dca_taPersCaGrp_dca_taPersonasCa"
  add_foreign_key "dca_taPersonasCaPermisos", "dca_taPermisos", column: "PermisoID", primary_key: "PermisoID", name: "FK_dca_taPersCaPerm_dca_taPermisos"
  add_foreign_key "dca_taPersonasCaPermisos", "dca_taPersonasCa", column: "PersonaCaID", primary_key: "PersonaCaID", name: "FK_dca_taPersCaPerm_dca_taPersonasCa"
  add_foreign_key "dca_taPersonasCaTarjetas", "dca_taPersonasCa", column: "PersonaCaID", primary_key: "PersonaCaID", name: "FK_dca_taPersCaTarj_dca_taPersonasCa"
  add_foreign_key "dca_taPersonasCaTarjetas", "dca_taTarjetas", column: "TarjID", primary_key: "TarjID", name: "FK_dca_taPersCaTarj_dca_taTarjetas"
  add_foreign_key "dvi_taAsegurables", "dc_taPerfiles", column: "PerfilID", primary_key: "PerfilID", name: "FK_dvi_taAsegurables_dc_taPerfiles"
  add_foreign_key "dvi_taAsegurables", "dvi_taAsegurables", column: "AsegPadreID", primary_key: "AsegID", name: "FK_dvi_taAsegurables_dvi_taAsegurables"
  add_foreign_key "dvi_taCategs", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dvi_taCategs_dc_taEmpresas"
  add_foreign_key "dvi_taCitas", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dvi_taCitas_dc_taEmpresas"
  add_foreign_key "dvi_taCitas", "dvi_taMotivos", column: "MotivoID", primary_key: "MotivoID", name: "FK_dvi_taCitas_dvi_taMotivos"
  add_foreign_key "dvi_taCitas", "dvi_taVdos", column: "VdoID", primary_key: "VdoID", name: "FK_dvi_taCitas_dvi_taVdos"
  add_foreign_key "dvi_taCitas", "dvi_taVisAreas", column: "AreaID", primary_key: "AreaID", name: "FK_dvi_taCitas_dvi_taVisAreas"
  add_foreign_key "dvi_taCitas", "dvi_taVtes", column: "VteID", primary_key: "VteID", name: "FK_dvi_taCitas_dvi_taVtes"
  add_foreign_key "dvi_taCitasNotas", "dvi_taCitas", column: "CitaID", primary_key: "CitaID", name: "FK_dvi_taCitasNotas_dvi_taCitas"
  add_foreign_key "dvi_taCitasNotas", "dvi_taMotivos", column: "MotivoID", primary_key: "MotivoID", name: "FK_dvi_taCitasNotas_dvi_taMotivos"
  add_foreign_key "dvi_taEmpres", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dvi_taEmpres_dc_taEmpresas"
  add_foreign_key "dvi_taMotivos", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dvi_taMotivos_dc_taEmpresas"
  add_foreign_key "dvi_taMovimVisPert", "dvi_taMovimVis", column: "MovimID", primary_key: "MovimID", name: "FK_dvi_taMovimVisPert_dvi_taMovimVis"
  add_foreign_key "dvi_taMovimVisPert", "dvi_taPertenencias", column: "PertenenciaID", primary_key: "PertenenciaID", name: "FK_dvi_taMovimVisPert_dvi_taPertenencias"
  add_foreign_key "dvi_taPertenencias", "dvi_taVtes", column: "VteID", primary_key: "VteID", name: "FK_dvi_taPertenencias_dvi_taVtes"
  add_foreign_key "dvi_taPoliticas", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dvi_taPoliticas_dc_taEmpresas"
  add_foreign_key "dvi_taPrivilegios", "dvi_taAsegurables", column: "AsegID", primary_key: "AsegID", name: "FK_dvi_taPrivilegios_dvi_taAsegurables"
  add_foreign_key "dvi_taPrivilegios", "dvi_taRoles", column: "RolID", primary_key: "RolID", name: "FK_dvi_taPrivilegios_dvi_taRoles"
  add_foreign_key "dvi_taRoles", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dvi_taRoles_dc_taEmpresas"
  add_foreign_key "dvi_taRolesUsuarios", "dc_taUsuarios", column: "UsuarioID", primary_key: "UsuarioID", name: "FK_dvi_taRolesUsuarios_dc_taUsuarios"
  add_foreign_key "dvi_taRolesUsuarios", "dvi_taRoles", column: "RolID", primary_key: "RolID", name: "FK_dvi_taRolesUsuarios_dvi_taRoles"
  add_foreign_key "dvi_taSolicitudesAsoc", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dc_dvi_taSolicitudesAsoc_dc_taEmpresas"
  add_foreign_key "dvi_taSolicitudesAsoc", "dc_taUsuarios", column: "UsuarioID", primary_key: "UsuarioID", name: "FK_dc_dvi_taSolicitudesAsoc_dc_taUsuarios"
  add_foreign_key "dvi_taVdos", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dvi_taVdos_dc_taEmpresas"
  add_foreign_key "dvi_taVdos", "dc_taPersonas", column: "PersonaID", primary_key: "PersonaID", name: "FK_dvi_taVdos_dc_taPersonas"
  add_foreign_key "dvi_taVdos", "dvi_taVisAreas", column: "AreaID", primary_key: "AreaID", name: "FK_dvi_taVdos_dvi_taVisAreas"
  add_foreign_key "dvi_taVisAreas", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dvi_taVisAreas_dc_taEmpresas"
  add_foreign_key "dvi_taVisAreasHorarios", "dvi_taVisAreas", column: "AreaID", primary_key: "AreaID", name: "FK_dvi_taVisAreasHorarios_dvi_taVisAreas"
  add_foreign_key "dvi_taVisAreasHorarios", "dvi_taVisHorarios", column: "HorarioID", primary_key: "HorarioID", name: "FK_dvi_taVisAreasHorarios_dvi_taVisHorarios"
  add_foreign_key "dvi_taVisHorarios", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dvi_taVisHorarios_dc_taEmpresas"
  add_foreign_key "dvi_taVisHorariosD", "dvi_taVisHorarios", column: "HorarioID", primary_key: "HorarioID", name: "FK_dvi_taVisHorariosD_dvi_taVisHorarios"
  add_foreign_key "dvi_taVtes", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dvi_taVtes_dc_taEmpresas"
  add_foreign_key "dvi_taVtes", "dc_taPersonas", column: "PersonaID", primary_key: "PersonaID", name: "FK_dvi_taVtes_dc_taPersonas"
  add_foreign_key "dvi_taVtes", "dvi_taCategs", column: "CategID", primary_key: "CategID", name: "FK_dvi_taVtes_dvi_taCategs"
  add_foreign_key "dvi_taVtes", "dvi_taEmpres", column: "EmpreID", primary_key: "EmpreID", name: "FK_dvi_taVtes_dvi_taEmpres"
  add_foreign_key "rcp_taDeviceServices", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_rcp_taDeviceServices_dc_taEmpresas"
  add_foreign_key "rcp_taEmpresasUsuarios", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_rcp_taEmpresasUsuarios_dc_taEmpresas"
  add_foreign_key "rcp_taEmpresasUsuarios", "dc_taUsuarios", column: "UsuarioID", primary_key: "UsuarioID", name: "FK_rcp_taEmpresasUsuarios_dc_taUsuarios"
  add_foreign_key "rcp_taHorarios", "rcp_taPlanes", column: "PlanID", primary_key: "PlanID", name: "FK_rcp_taHorarios_rcp_taPlanes"
  add_foreign_key "rcp_taModelosRelojes", "rcp_taBioFormatos", column: "FmtHuellaID", primary_key: "FmtID", name: "FK_rcp_taModelosRelojes_rcp_taBioFmtH"
  add_foreign_key "rcp_taModelosRelojesAcciones", "rcp_taAcciones", column: "AccionID", primary_key: "AccionID", name: "FK_rcp_taModelosRelojesAcciones_rcp_taAcciones"
  add_foreign_key "rcp_taModelosRelojesAcciones", "rcp_taModelosRelojes", column: "RcpModeloID", primary_key: "RcpModeloID", name: "FK_rcp_taModelosRelojesAcciones_rcp_taModelosRelojes"
  add_foreign_key "rcp_taPlanes", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_rcp_taPlanes_dc_taEmpresas"
  add_foreign_key "rcp_taPrivilegios", "rcp_taAsegurables", column: "AsegID", primary_key: "AsegID", name: "FK_rcp_taPrivilegios_rcp_taAsegurables"
  add_foreign_key "rcp_taPrivilegios", "rcp_taRoles", column: "RolID", primary_key: "RolID", name: "FK_rcp_taPrivilegios_rcp_taRoles"
  add_foreign_key "rcp_taRelojes", "rcp_taDeviceServices", column: "DeviceServiceID", primary_key: "DeviceServiceID", name: "FK_rcp_taRelojes_rcp_taDevicesServices"
  add_foreign_key "rcp_taRelojes", "rcp_taModelosRelojes", column: "RcpModeloID", primary_key: "RcpModeloID", name: "FK_rcp_taRelojes_rcp_taModelosRelojes"
  add_foreign_key "rcp_taRelojes", "rcp_taModosAutenticacion", column: "Autenticacion", primary_key: "Autenticacion", name: "FK_rcp_taRelojes_rcp_taModosAutenticacion"
  add_foreign_key "rcp_taRelojes", "rcp_taRelojesSentidoFichada", column: "SentidoFichadaID", primary_key: "SentidoFichadaID", name: "FK_rcp_taRelojes_rcp_taRelojesSentidoFichada"
  add_foreign_key "rcp_taRelojesUsuariosMinucias", "rcp_taRelojesUsuarios", column: "RegID", primary_key: "RegID", name: "FK_rcp_taRelojesUsuariosMinucias_rcp_taRelojesUsuarios"
  add_foreign_key "rcp_taRelojesUsuariosTarjetas", "rcp_taRelojesUsuarios", column: "RegID", primary_key: "RegID", name: "FK_rcp_taRelojesUsuariosTarjetas_rcp_taRelojesUsuarios"
  add_foreign_key "rcp_taRoles", "dc_taEmpresas", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_rcp_taRoles_dc_taEmpresas"
  add_foreign_key "rcp_taRolesUsuarios", "dc_taUsuarios", column: "UsuarioID", primary_key: "UsuarioID", name: "FK_rcp_taRolesUsuarios_dc_taUsuarios"
  add_foreign_key "rcp_taRolesUsuarios", "rcp_taRoles", column: "RolID", primary_key: "RolID", name: "FK_rcp_taRolesUsuarios_rcp_taRoles"
  add_foreign_key "rcp_taTareas", "rcp_taAcciones", column: "AccionID", primary_key: "AccionID", name: "FK_rcp_taTareas_rcp_taAcciones"
  add_foreign_key "rcp_taTareas", "rcp_taPlanes", column: "PlanID", primary_key: "PlanID", name: "FK_rcp_taTareas_rcp_taPlanes"
  add_foreign_key "rcp_taTareas", "rcp_taRelojes", column: "RelojID", primary_key: "RelojID", name: "FK_rcp_taTareas_rcp_taRelojes"
end
