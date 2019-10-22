
    <update id="update">
        UPDATE ${sense}${schema}${sense}.${sense}${tableName}${sense}
        SET
        <include refid="baseUpdate"></include>
        WHERE
        <include refid="baseSimpleCondition"></include>
    </update>

    <update id="updateBatch">
        <if test="list!=null and list.size > 0">
            UPDATE ${sense}${schema}${sense}.${sense}${tableName}${sense} record
            SET
            <trim suffixOverrides=",">
                <#list attrs as attr>
                    <#if attr.isAuto == "NO" && attr.isKey == 0>
                        ${sense}${attr.columnName}${sense} = tmp.${sense}${attr.columnName}${sense},
                    </#if>
                </#list>
            </trim>
            FROM
            (VALUES
            <foreach collection="list" item="item" separator=",">
                (
                <trim suffixOverrides=",">
                    <#list attrs as attr>
                        ${"#\{item."}${attr.propertiesName}}::${attr.typeName},
                    </#list>
                </trim>
                )
            </foreach>
            ) AS tmp (
            <include refid="baseFields"></include>
            )
            WHERE
            <trim suffixOverrides="and">
                <#list attrs as attr>
                    <#if attr.isKey == 1>
                        record.${sense}${attr.columnName}${sense} = tmp.${sense}${attr.columnName}${sense} and
                    </#if>
                </#list>
            </trim>
        </if>
    </update>

    <sql id="baseUpdate">
        <trim suffixOverrides=",">
            <#list attrs as attr>
                <#if attr.isAuto == "NO" && attr.isKey == 0>
                    <if test="${attr.propertiesName} != null">
                        ${sense}${attr.columnName}${sense} = ${"#\{"}${attr.propertiesName}}::${attr.typeName},
                    </if>
                </#if>
            </#list>
        </trim>
    </sql>


    <sql id="baseSimpleCondition">
        <trim suffixOverrides="and">
            <#list attrs as attr>
                <#if attr.isKey == 1>
                    ${sense}${attr.columnName}${sense} = ${"#\{"}${attr.propertiesName}}::${attr.typeName} and
                </#if>
            </#list>
        </trim>
    </sql>