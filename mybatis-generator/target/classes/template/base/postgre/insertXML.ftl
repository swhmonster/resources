
    <insert id="insert" <#if tableAttrs.autoKey??> useGeneratedKeys="true" keyProperty="${tableAttrs.autoKey}"</#if>>
        INSERT INTO ${sense}${schema}${sense}.${sense}${tableName}${sense}
        (
        <include refid="baseFields"></include>
        )
        VALUES
        (
        <trim suffixOverrides=",">
            <#list attrs as attr>
                ${"#\{"}${attr.propertiesName}}::${attr.typeName},
            </#list>
        </trim>
        )
    </insert>


    <insert id="insertBatch" <#if tableAttrs.autoKey??> useGeneratedKeys="true" keyProperty="${tableAttrs.autoKey}"</#if>>
        <if test="list!=null and list.size > 0">
            INSERT INTO ${sense}${schema}${sense}.${sense}${tableName}${sense}
            (
            <include refid="baseFields"></include>
            )
            VALUES
            <foreach collection="list" item="item" separator=",">
                (
                <trim suffixOverrides=",">
                    <#list attrs as attr>
                        ${"#\{item."}${attr.propertiesName}}::${attr.typeName},
                    </#list>
                </trim>
                )
            </foreach>
        </if>
    </insert>

    <sql id="baseFields">
        <trim suffixOverrides=",">
            <#list attrs as attr>
                    ${sense}${attr.columnName}${sense},
            </#list>
        </trim>
    </sql>