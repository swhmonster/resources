    <resultMap type="${packageModel}.${className}" id="baseMap">
            <#list attrs as attr>
                <result property="${attr.propertiesName}" column="${attr.columnName}"/>
            </#list>
    </resultMap>


    <select id="query" resultMap="baseMap">
        select
        <include refid="baseResult"></include>
        from  ${sense}${schema}${sense}.${sense}${tableName}${sense}
        <include refid="baseCondition"></include>
    </select>

    <select id="queryLimit1" resultMap="baseMap">
        select
        <include refid="baseResult"></include>
        from  ${sense}${schema}${sense}.${sense}${tableName}${sense}
        <include refid="baseCondition"></include>
        limit 1
    </select>

    <sql id="baseResult">
        <trim suffixOverrides=",">
                <if test="fetchFields!=null">
                    <if test="fetchFields.AllFields !=null">
					<trim suffixOverrides=",">
						<#list attrs as attr>
							${attr.columnName},
						</#list>
					</trim>
                    </if>
                    <if test="fetchFields.AllFields==null and fetchFields.fetchFields!=null">
                <#list attrs as attr>
                    <if test="fetchFields.fetchFields.${attr.propertiesName}==true">
                        ${sense}${attr.columnName}${sense},
                    </if>
                </#list>
                    </if>
                </if>
        </trim>
    </sql>

    <sql id="baseCondition">
        <trim prefix="where" suffixOverrides="and | or">
            <#list attrs as attr>
                <if test="${attr.propertiesName} != null">
                    ${sense}${attr.columnName}${sense} = ${"#\{"}${attr.propertiesName}}::${attr.typeName} and
                </if>
            </#list>
            <#list attrs as attr>
                <if test="${attr.propertiesName}List != null">
                    ${sense}${attr.columnName}${sense} in
                    <foreach collection="${attr.propertiesName}List" close=")" open="(" separator="," item="item">
                        ${"#\{"}item}::${attr.typeName}
                    </foreach> and
                </if>
            </#list>
        </trim>
    </sql>