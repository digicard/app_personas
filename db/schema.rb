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

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dc_taEmpresas", primary_key: "EmpresaID", id: :serial, force: :cascade do |t|
    t.string "Nombre", limit: 128, null: false
    t.string "CUIT", limit: 15, null: false
    t.string "Descripcion", limit: 256
    t.boolean "Habilitada", default: true, null: false
  end

  create_table "dc_taPersonas", primary_key: "PersonaID", id: :serial, force: :cascade do |t|
    t.string "Apellido", limit: 128, null: false
    t.string "Nombre", limit: 128, null: false
    t.string "TDoc", limit: 16, null: false
    t.string "NDoc", limit: 32, null: false
    t.string "CUIL", limit: 15
    t.boolean "Habilitada", default: true, null: false
    t.binary "Foto"
  end

  create_table "dca_SujetoC", primary_key: "SujetoCID", id: :serial, force: :cascade do |t|
    t.date "FecAlta", null: false
    t.date "FecBaja"
    t.boolean "Habilitada", default: true, null: false
    t.string "Contacto", limit: 512
    t.integer "CategID", null: false
    t.integer "PersonaID", null: false
    t.integer "EmpresaID", null: false
    t.integer "UltMovimID"
  end

  create_table "dca_taCategs", primary_key: "CategID", id: :serial, force: :cascade do |t|
    t.string "Nombre", limit: 30, null: false
    t.string "Descripcion", limit: 50
    t.integer "EmpresaID", null: false
  end

  create_table "dca_taConfig", primary_key: "CfgID", id: :serial, force: :cascade do |t|
    t.string "CfgNombre", limit: 64, null: false
    t.string "Comentario", limit: 256
    t.string "ValorDef", limit: 64, null: false
    t.string "ValorCorr", limit: 64, null: false
    t.integer "EmpresaID"
  end

  add_foreign_key "dca_SujetoC", "\"dc_taEmpresas\"", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dca_dca_taSujetoC_dc_taEmpresas"
  add_foreign_key "dca_SujetoC", "\"dc_taPersonas\"", column: "PersonaID", primary_key: "PersonaID", name: "FK_dca_dca_taSujetoC_dc_taPersonas"
  add_foreign_key "dca_SujetoC", "\"dca_taCategs\"", column: "CategID", primary_key: "CategID", name: "FK_dca_taSujetoC_dca_taCategs"
  add_foreign_key "dca_taCategs", "\"dc_taEmpresas\"", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dca_dca_taCategs_dc_taEmpresas"
  add_foreign_key "dca_taConfig", "\"dc_taEmpresas\"", column: "EmpresaID", primary_key: "EmpresaID", name: "FK_dca_dca_taConfig_dc_taEmpresas"
end
