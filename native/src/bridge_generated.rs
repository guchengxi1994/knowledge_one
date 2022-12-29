#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case,
    clippy::too_many_arguments
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.58.2.

use crate::api::*;
use core::panic::UnwindSafe;
use flutter_rust_bridge::*;
use std::ffi::c_void;
use std::sync::Arc;

// Section: imports

use crate::database::model::changelog::FileChangelog;
use crate::database::model::changelog::NativeFileNewVersion;
use crate::database::model::file::FileDetails;
use crate::database::model::file::NativeFileSummary;
use crate::database::model::todo::TodoDetails;
use crate::database::model::todo_status::TodoStatus;

// Section: wire functions

fn wire_create_all_directory_impl(port_: MessagePort, s: impl Wire2Api<String> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "create_all_directory",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_s = s.wire2api();
            move |task_callback| Ok(create_all_directory(api_s))
        },
    )
}
fn wire_get_changelog_from_id_impl(
    port_: MessagePort,
    id: impl Wire2Api<i64> + UnwindSafe,
    file_hash: impl Wire2Api<String> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "get_changelog_from_id",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_id = id.wire2api();
            let api_file_hash = file_hash.wire2api();
            move |task_callback| Ok(get_changelog_from_id(api_id, api_file_hash))
        },
    )
}
fn wire_get_file_hash_impl(port_: MessagePort, file_path: impl Wire2Api<String> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "get_file_hash",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_file_path = file_path.wire2api();
            move |task_callback| Ok(get_file_hash(api_file_path))
        },
    )
}
fn wire_delete_file_by_file_hash_impl(
    port_: MessagePort,
    file_hash: impl Wire2Api<String> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "delete_file_by_file_hash",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_file_hash = file_hash.wire2api();
            move |task_callback| Ok(delete_file_by_file_hash(api_file_hash))
        },
    )
}
fn wire_change_version_control_impl(
    port_: MessagePort,
    file_hash: impl Wire2Api<String> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "change_version_control",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_file_hash = file_hash.wire2api();
            move |task_callback| Ok(change_version_control(api_file_hash))
        },
    )
}
fn wire_create_new_version_impl(
    port_: MessagePort,
    model: impl Wire2Api<NativeFileNewVersion> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "create_new_version",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_model = model.wire2api();
            move |task_callback| Ok(create_new_version(api_model))
        },
    )
}
fn wire_create_new_disk_file_impl(
    port_: MessagePort,
    file_path: impl Wire2Api<String> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "create_new_disk_file",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_file_path = file_path.wire2api();
            move |task_callback| Ok(create_new_disk_file(api_file_path))
        },
    )
}
fn wire_get_file_logs_impl(port_: MessagePort, file_hash: impl Wire2Api<String> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "get_file_logs",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_file_hash = file_hash.wire2api();
            move |task_callback| Ok(get_file_logs(api_file_hash))
        },
    )
}
fn wire_change_file_hash_by_id_impl(
    port_: MessagePort,
    ori_file_path: impl Wire2Api<String> + UnwindSafe,
    file_path: impl Wire2Api<String> + UnwindSafe,
    file_id: impl Wire2Api<i64> + UnwindSafe,
    diff_path: impl Wire2Api<Option<String>> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "change_file_hash_by_id",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_ori_file_path = ori_file_path.wire2api();
            let api_file_path = file_path.wire2api();
            let api_file_id = file_id.wire2api();
            let api_diff_path = diff_path.wire2api();
            move |task_callback| {
                Ok(change_file_hash_by_id(
                    api_ori_file_path,
                    api_file_path,
                    api_file_id,
                    api_diff_path,
                ))
            }
        },
    )
}
fn wire_init_mysql_impl(port_: MessagePort, conf_path: impl Wire2Api<String> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "init_mysql",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_conf_path = conf_path.wire2api();
            move |task_callback| Ok(init_mysql(api_conf_path))
        },
    )
}
fn wire_get_status_types_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "get_status_types",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Ok(get_status_types()),
    )
}
fn wire_get_todos_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "get_todos",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Ok(get_todos()),
    )
}
fn wire_get_files_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "get_files",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Ok(get_files()),
    )
}
fn wire_new_file_impl(port_: MessagePort, f: impl Wire2Api<NativeFileSummary> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "new_file",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_f = f.wire2api();
            move |task_callback| Ok(new_file(api_f))
        },
    )
}
// Section: wrapper structs

// Section: static checks

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null()).then(|| self.wire2api())
    }
}

impl Wire2Api<i64> for i64 {
    fn wire2api(self) -> i64 {
        self
    }
}

impl Wire2Api<u8> for u8 {
    fn wire2api(self) -> u8 {
        self
    }
}

// Section: impl IntoDart

impl support::IntoDart for FileChangelog {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.changelog_id.into_dart(),
            self.file_id.into_dart(),
            self.version_id.into_dart(),
            self.prev_version_id.into_dart(),
            self.is_deleted.into_dart(),
            self.create_at.into_dart(),
            self.update_at.into_dart(),
            self.file_length.into_dart(),
            self.file_path.into_dart(),
            self.diff_path.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for FileChangelog {}

impl support::IntoDart for FileDetails {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.file_id.into_dart(),
            self.file_name.into_dart(),
            self.file_path.into_dart(),
            self.is_deleted.into_dart(),
            self.create_at.into_dart(),
            self.update_at.into_dart(),
            self.file_hash.into_dart(),
            self.version_control.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for FileDetails {}

impl support::IntoDart for TodoDetails {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.todo_id.into_dart(),
            self.todo_name.into_dart(),
            self.todo_content.into_dart(),
            self.todo_status_name.into_dart(),
            self.todo_from.into_dart(),
            self.todo_to.into_dart(),
            self.task_name.into_dart(),
            self.task_id.into_dart(),
            self.todo_status_color.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for TodoDetails {}

impl support::IntoDart for TodoStatus {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.todo_status_id.into_dart(),
            self.todo_status_name.into_dart(),
            self.todo_status_color.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for TodoStatus {}

// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

/// cbindgen:ignore
#[cfg(target_family = "wasm")]
#[path = "bridge_generated.web.rs"]
mod web;
#[cfg(target_family = "wasm")]
pub use web::*;

#[cfg(not(target_family = "wasm"))]
#[path = "bridge_generated.io.rs"]
mod io;
#[cfg(not(target_family = "wasm"))]
pub use io::*;
