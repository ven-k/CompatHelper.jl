function has_ssh_private_key(; env::AbstractDict=ENV)
    return haskey(env, PRIVATE_SSH_ENVVAR) && env[PRIVATE_SSH_ENVVAR] != "false"
end

lower(str::AbstractString) = lowercase(strip(str))

function _max(x::Union{Nothing,Any}, y)
    if x === nothing
        return y
    else
        return max(x, y)
    end
end

function with_temp_dir(f::Function; kwargs...)
    original_dir = pwd()
    tmp_dir = mktempdir(; kwargs...)
    atexit(() -> rm(tmp_dir; force=true, recursive=true))

    cd(tmp_dir)
    result = f(tmp_dir)
    cd(original_dir)

    rm(tmp_dir; force=true, recursive=true)
    return result
end

function add_compat_section!(project::Dict)
    if !haskey(project, "compat")
        project["compat"] = Dict{Any, Any}()
    end
end


function get_random_string()
    return string(utc_to_string(now_localzone()), "-", rand(UInt32))
end
